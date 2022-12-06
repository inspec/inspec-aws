require 'aws_backend'

class AwsEbsSnapshots < AwsResourceBase
  name 'aws_ebs_snapshots'
  desc 'Verifies settings for a collection of AWS EBS Snapshots.'
  example "
    describe aws_ebs_snapshots do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:snapshot_ids, field: :snapshot_id)
             .register_column(:owner_ids,    field: :owner_id)
             .register_column(:encrypted,    field: :encrypted)
             .register_column(:tags,         field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    fetch_data
  end

  def fetch_data
    snapshot_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_snapshots(pagination_options)
      end
      return snapshot_rows if !@api_response || @api_response.empty?

      snapshot_rows += @api_response.snapshots.map(&:to_h)

      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = snapshot_rows
  end
end
