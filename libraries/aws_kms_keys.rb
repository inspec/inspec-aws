require "aws_backend"

class AwsKmsKeys < AwsResourceBase
  name "aws_kms_keys"
  desc "Verifies settings for AWS KMS Keys in bulk."
  example "
    describe aws_kms_keys do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:key_ids,  field: :key_id)
    .register_column(:key_arns, field: :key_arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    key_rows = []
    pagination_options = { limit: 1000 }
    loop do
      catch_aws_errors do
        @api_response = @aws.kms_client.list_keys(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.keys.map do |key|
        key_rows += [{ key_id: key.key_id,
                       key_arn: key.key_arn }]
      end
      break unless @api_response.truncated
      pagination_options = { marker: @api_response.next_marker }
    end
    @table = key_rows
  end
end
