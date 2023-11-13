require "aws_backend"

class AWSIAMOIDCProviders < AwsResourceBase
  name "aws_iam_oidc_providers"
  desc "Lists all OIDC Providers."

  example "
    describe aws_iam_oidc_providers do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns, field: :arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    aws_iam_oidc_providers_rows = []
    catch_aws_errors do
      @response = @aws.iam_client.list_open_id_connect_providers
    end
    return aws_iam_oidc_providers_rows if !@response || @response.empty?
    @response.open_id_connect_provider_list.each do |provider|
      aws_iam_oidc_providers_rows += [{
        arn: provider.arn,
      }]
    end
    @table = aws_iam_oidc_providers_rows
  end
end
