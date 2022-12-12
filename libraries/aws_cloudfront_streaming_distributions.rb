require "aws_backend"

class AWSCloudFrontStreamingDistributions < AwsResourceBase
  name "aws_cloudfront_streaming_distributions"
  desc "List streaming distributions."
  example <<-EXAMPLE
    describe aws_cloudfront_streaming_distributions do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:ids, field: :id)
    .register_column(:arns, field: :arn)
    .register_column(:statuses, field: :status)
    .register_column(:last_modified_time, field: :last_modified_time)
    .register_column(:domain_names, field: :domain_name)
    .register_column(:s3_origins, field: :s3_origin)
    .register_column(:aliases, field: :aliases)
    .register_column(:trusted_signers, field: :trusted_signers)
    .register_column(:comments, field: :comment)
    .register_column(:price_classes, field: :price_class)
    .register_column(:enabled, field: :enabled)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudfront_client.list_streaming_distributions.map do |table|
        table.streaming_distribution_list.items.map { |table_name| {
          id: table_name.id,
          arn: table_name.arn,
          status: table_name.status,
          last_modified_time: table_name.last_modified_time,
          domain_name: table_name.domain_name,
          s3_origin: table_name.s3_origin,
          aliases: table_name.aliases,
          trusted_signers: table_name.trusted_signers,
          comments: table_name.comment,
          price_class: table_name.price_class,
          enabled: table_name.enabled,
        }
        }
      end.flatten
    end
  end
end
