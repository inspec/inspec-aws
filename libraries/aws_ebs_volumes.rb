# frozen_string_literal: true

require 'aws_backend'

class AwsEbsVolumes < AwsResourceBase
  name 'aws_ebs_volumes'
  desc 'Verifies settings for AWS EBS Volumes in bulk'
  example '
    describe aws_ebs_volumes do
      it { should exist }
    end
  '

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:volume_ids, field: :volume_id)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    volume_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_volumes(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.volumes.map do |volume|
        volume_rows += [{ volume_id: volume.volume_id }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = volume_rows
  end
end
