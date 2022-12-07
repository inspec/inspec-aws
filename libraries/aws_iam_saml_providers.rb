require 'aws_backend'

class AwsIamSamlProviders < AwsResourceBase
  name 'aws_iam_saml_providers'
  desc 'Verifies settings for a collection of SAML Providers.'
  example "
    describe aws_iam_saml_providers do
      it { should exist }
    end
  "
  supports platform: 'aws'

  attr_reader :table

  FilterTable.create
             .register_column(:provider_arns, field: :arn)
             .register_column(:valid_untils, field: :valid_until)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    provider_rows = []
    catch_aws_errors do
      providers = @aws.iam_client.list_saml_providers
      return [] if !providers || providers.empty?

      providers.saml_provider_list.each do |p|
        provider_rows += [{ arn:      p.arn,
                         valid_until: p.valid_until,
                         create_date: p.create_date }]
      end
    end

    @table = provider_rows
  end

  def to_s
    'AWS IAM SAML Providers'
  end
end
