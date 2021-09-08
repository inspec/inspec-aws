require 'helper'
require 'aws_api_gatewayv2_domain_name'
require 'aws-sdk-core'

class AWSApiGatewayV2DomainNameConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2DomainName.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2DomainName.new(domain_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2DomainName.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2DomainNameSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_domain_name
    mock_data = {}
    mock_data[:api_mapping_selection_expression] = 'test1'
    mock_data[:domain_name] = 'test1'
    mock_data[:domain_name_configurations] = [{
                                                api_gateway_domain_name: 'test1',
                                                certificate_arn: 'test1',
                                                certificate_name: 'test1',
                                                certificate_upload_date: Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
                                                domain_name_status: 'test1',
                                                domain_name_status_message: 'test1',
                                                endpoint_type: 'test1',
                                                hosted_zone_id: 'test1',
                                                security_policy: 'test1'
                                              }]
    mock_data[:mutual_tls_authentication] = {
      truststore_uri: 'test1',
      truststore_version: 'test1',
      truststore_warnings: ['test1']
    }
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2DomainName.new(domain_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_name_exists
    assert @resp.exists?
  end

  def test_api_mapping_selection_expression
    assert_equal(@resp.api_mapping_selection_expression, 'test1')
  end

  def test_domain_name
    assert_equal(@resp.domain_name, 'test1')
  end

  def test_api_gateway_domain_name
    assert_equal(@resp.domain_name_configurations[0].api_gateway_domain_name, 'test1')
  end

  def test_certificate_arn
    assert_equal(@resp.domain_name_configurations[0].certificate_arn, 'test1')
  end

  def test_certificate_name
    assert_equal(@resp.domain_name_configurations[0].certificate_name, 'test1')
  end

  def test_certificate_upload_date
    assert_equal(@resp.domain_name_configurations[0].certificate_upload_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_domain_name_status
    assert_equal(@resp.domain_name_configurations[0].domain_name_status, 'test1')
  end

  def test_domain_name_status_message
    assert_equal(@resp.domain_name_configurations[0].domain_name_status_message, 'test1')
  end

  def test_endpoint_type
    assert_equal(@resp.domain_name_configurations[0].endpoint_type, 'test1')
  end

  def test_hosted_zone_id
    assert_equal(@resp.domain_name_configurations[0].hosted_zone_id, 'test1')
  end

  def test_security_policy
    assert_equal(@resp.domain_name_configurations[0].security_policy, 'test1')
  end

  def test_api_gateway_domain_name
    assert_equal(@resp.domain_name_configurations[0].api_gateway_domain_name, 'test1')
  end

  def test_truststore_uri
    assert_equal(@resp.mutual_tls_authentication.truststore_uri, 'test1')
  end

  def test_truststore_version
    assert_equal(@resp.mutual_tls_authentication.truststore_version, 'test1')
  end

  def test_truststore_warnings
    assert_equal(@resp.mutual_tls_authentication.truststore_warnings, ['test1'])
  end
end
