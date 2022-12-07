require 'helper'
require 'aws_apigateway_client_certificate'
require 'aws-sdk-core'

class AWSApiGatewayClientCertificateConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayClientCertificate.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayClientCertificate.new(client_certificate_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayClientCertificate.new(unexpected: 9) }
  end
end

class AWSApiGatewayClientCertificateSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_client_certificate
    mock_data = {}
    mock_data[:client_certificate_id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:pem_encoded_certificate] = 'test1'
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:expiration_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayClientCertificate.new(client_certificate_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_client_certificate_exists
    assert @resp.exists?
  end

  def test_client_certificate_id
    assert_equal(@resp.client_certificate_id, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_pem_encoded_certificate
    assert_equal(@resp.pem_encoded_certificate, 'test1')
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_expiration_date
    assert_equal(@resp.expiration_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end
