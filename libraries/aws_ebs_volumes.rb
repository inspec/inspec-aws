# frozen_string_literal: true

require 'aws_backend'

class AwsEbsVolumes < AwsResourceBase
  name 'aws_ebs_volumes'
  desc 'Verifies settings for a collection of AWS EBS Volumes'
  example '
    describe aws_ebs_volumes do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:volume_ids, field: :volume_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

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
