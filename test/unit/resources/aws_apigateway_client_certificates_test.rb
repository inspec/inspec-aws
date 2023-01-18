require 'helper'
require 'aws_apigateway_client_certificates'
require 'aws-sdk-core'

class AWSApiGatewayClientCertificatesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayClientCertificates.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayClientCertificates.new('rubbish') }
  end

  def test_api_mapping_client_certificates_non_existing_for_empty_response
    refute AWSApiGatewayClientCertificates.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayClientCertificatesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_client_certificates
    mock_data = {}
    mock_data[:client_certificate_id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:pem_encoded_certificate] = 'test1'
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:expiration_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:tags] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayClientCertificates.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_client_certificate_ids
    assert_equal(@resp.client_certificate_ids, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_pem_encoded_certificates
    assert_equal(@resp.pem_encoded_certificates, ['test1'])
  end

  def test_created_dates
    assert_equal(@resp.created_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_expiration_dates
    assert_equal(@resp.expiration_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_tags
    assert_equal(@resp.tags, [{}])
  end
end
