# frozen_string_literal: true

require 'aws_backend'

class AwsEbsSnapshots < AwsResourceBase
  name 'aws_ebs_snapshots'
  desc 'Verifies settings for a collection of AWS EBS Snapshots'
  example '
    describe aws_ebs_snapshots do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:snapshot_ids, field: :snapshot_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    snapshot_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_snapshots(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.snapshots.map do |snapshot|
        snapshot_rows += [{ snapshot_id: snapshot.snapshot_id }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = snapshot_rows
  end
end
