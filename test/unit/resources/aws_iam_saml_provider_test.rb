require 'aws-sdk-core'
require 'aws_iam_saml_provider'
require 'helper'
require_relative 'mock/iam/aws_iam_saml_provider_mock'

class AwsIamSamlProviderTest < Minitest::Test

  def setup
    # Given
    @mock          = AwsIamSamlProviderMock.new
    @mock_provider = @mock.provider

    # When
    @provider = AwsIamSamlProvider.new(saml_provider_arn: @mock_provider[:saml_provider_arn],
                                       client_args: { stub_responses: true },
                                       stub_data: @mock.stub_data)
  end

  def test_exists
    assert(@provider.exists?)
  end

  def test_arn
    assert_equal(@provider.arn, @mock_provider[:saml_provider_arn])
  end

  def test_create_date
    assert_equal(@provider.create_date, @mock_provider[:create_date])
  end

  def test_valid_until
    assert_equal(@provider.valid_until, @mock_provider[:valid_until])
  end
end