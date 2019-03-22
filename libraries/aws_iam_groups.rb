# frozen_string_literal: true

require 'aws_backend'

class AwsIamGroups < AwsResourceBase
  name 'aws_iam_groups'
  desc 'Verifies settings for a collection AWS IAM Groups'
  example '
    describe aws_iam_groups do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:group_names,  field: :group_name)
             .register_column(:group_ids,    field: :group_id)
             .register_column(:arns,         field: :arn)
             .register_column(:users,        field: :users)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    group_rows = []
    groups = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        groups = @aws.iam_client.list_groups(pagination_options)
        return [] if !groups || groups.empty?

        groups.groups.each do |g|
          group_rows += [{ group_name: g.group_name,
                           group_id:   g.group_id,
                           arn:        g.arn,
                           users:      @aws.iam_client.get_group({ 'group_name': g.group_name }).users.map(&:user_name) }]
        end
      end
      break unless groups.marker
      pagination_options = { marker: groups.marker }
    end
    @table = group_rows
  end
end
