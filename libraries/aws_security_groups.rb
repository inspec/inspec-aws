# frozen_string_literal: true

require 'aws_backend'

class AwsSecurityGroups < AwsResourceBase
  name 'aws_security_groups'
  desc 'Verifies settings for AWS Security Groups in bulk'
  example "
    # Verify that you have security groups defined
    describe aws_security_groups do
      it { should exist }
    end

    # Verify you have more than the default security group
    describe aws_security_groups do
      its('entries.count') { should be > 1 }
    end
  "

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:group_ids, field: :group_id)
  filter_table_config.add(:vpc_ids, field: :vpc_id)
  filter_table_config.add(:group_names, field: :group_name)
  filter_table_config.add(:tags, field: :tags)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    security_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_security_groups(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.security_groups.map do |security_group|
        security_group_rows += [{
          group_id: security_group.group_id,
                                    vpc_id: security_group.vpc_id,
                                    group_name: security_group.group_name,
                                    tags: fetch_tags(security_group.tags),
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = security_group_rows
  end

  def fetch_tags(tag_list)
    tags = {}
    tag_list.each do |tag|
      tags[tag[:key].to_sym] = tag[:value]
    end
    tags
  end
end
