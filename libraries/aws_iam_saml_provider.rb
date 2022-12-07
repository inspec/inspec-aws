require 'aws_backend'

class AwsIamSamlProvider < AwsResourceBase
  name 'aws_iam_saml_provider'
  desc 'Verifies settings for a SAML Provider.'
  example "
    describe aws_iam_saml_provider('arn:aws:iam::123456789012:saml-provider/FANCY') do
        it { should exist }
        its('arn') { should match('arn:aws:iam::.*:saml-provider\/FANCY') }
        its('valid_until') { should be > Time.now + 90 * 86400 }
    end
  "
  supports platform: 'aws'

  attr_reader :provider, :arn, :saml_metadata_document, :create_date, :valid_until

  def initialize(opts = {})
    opts = { saml_provider_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:saml_provider_arn])

    catch_aws_errors do
      @provider = @aws.iam_client.get_saml_provider(saml_provider_arn: opts[:saml_provider_arn])
      @arn = opts[:saml_provider_arn]
      @create_date = @provider.create_date
      @valid_until = @provider.valid_until
      @saml_metadata_document = @provider.saml_metadata_document
    end
  end

  def resource_id
    @arn
  end

  def exists?
    !@provider.saml_metadata_document.nil?
  end

  def to_s
    "AWS IAM SAML Provider #{@opts[:saml_provider_arn]}"
  end
end
