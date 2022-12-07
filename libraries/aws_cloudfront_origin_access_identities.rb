require 'aws_backend'

class AWSCloudFrontOriginAccessIdentities < AwsResourceBase
  name 'aws_cloudfront_origin_access_identities'
  desc 'Lists origin access identities.'

  example "
    describe aws_cloudfront_origin_access_identities do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:s3_canonical_user_ids, field: :s3_canonical_user_id)
             .register_column(:comments, field: :comment)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudfront_client.list_cloud_front_origin_access_identities.map do |table|
        table.cloud_front_origin_access_identity_list.items.map { |table_name| {
          id: table_name.id,
          s3_canonical_user_id: table_name.s3_canonical_user_id,
          comment: table_name.comment,
        }
        }
      end.flatten
    end
  end
end
