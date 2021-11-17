require 'helper'
require 'aws_iam_oidc_provider'
require 'aws-sdk-core'

class AWSIAMOIDCProviderConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSIAMOIDCProvider.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSIAMOIDCProvider.new(open_id_connect_provider_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSIAMOIDCProvider.new(unexpected: 9) }
  end
end

class AWSIAMOIDCProviderSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_open_id_connect_provider
    mock_parameter = {}
    mock_parameter[:url] = 'test1.com'
    mock_parameter[:create_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] =  mock_parameter
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMOIDCProvider.new(open_id_connect_provider_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_oidc_provider_exists
    assert @resp.exists?
  end

  def test_url
    assert_equal(@resp.url, 'test1.com')
  end

  def test_create_date
    assert_equal(@resp.create_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end
