require_relative '../aws_base_resource_mock'

class AwsIamSamlProviderMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    @provider = OpenStruct.new(
        saml_provider_arn: @aws.any_arn,
        arn: @aws.any_arn,
        saml_metadata_document: @aws.any_string,
        create_date: @aws.any_date,
        valid_until: @aws.any_date
    )
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    [{ :client => Aws::IAM::Client, :method => :get_saml_provider, :data => @provider }]
  end

  def provider
    @provider
  end
end
