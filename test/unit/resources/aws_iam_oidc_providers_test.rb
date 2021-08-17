require 'helper'
require 'aws_iam_oidc_providers'
require 'aws-sdk-core'

class AWSIAMOIDCProvidersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSIAMOIDCProviders.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSIAMOIDCProviders.new('rubbish') }
  end

  def test_iam_client_non_existing_for_empty_response
    refute AWSIAMOIDCProviders.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSIAMOIDCProvidersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_open_id_connect_providers
    mock_data = {}
    mock_data[:arn] = 'test1'
    data[:data] = { :open_id_connect_provider_list => [mock_data] }
    data[:client] = Aws::IAM::Client
    @iam_client = AWSIAMOIDCProviders.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_oidc_iam_client_exists
    assert @iam_client.exist?
  end

  def test_arns
    assert_equal(@iam_client.arns, ['test1'])
  end
end
