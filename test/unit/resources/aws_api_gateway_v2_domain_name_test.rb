require 'helper'
require 'aws_api_gateway_v2_domain_name'
require 'aws-sdk-core'

class AwsApiGatewayV2DomainNameConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2DomainName.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2DomainName.new(api_id: '',  domain_name: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2DomainName.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2DomainNameSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_domain_name
    mock_data = {}
    mock_data[:api_mapping_selection_expression] = 'test_api_mapping_selection_expression'
    mock_data[:domain_name] = 'test_domain_name'
    mock_data[:domain_name_configurations] = [
      api_gateway_domain_name:  'test_api_gateway_domain_name',
      certificate_arn: 'test_certificate_arn',
      certificate_name: 'test_certificate_name',
      certificate_upload_date: Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
      domain_name_status: 'AVAILABLE',
      domain_name_status_message: 'test_domain_name_status_message',
      endpoint_type: 'EDGE',
      hosted_zone_id: 'test_hosted_zone_id',
      security_policy: 'TLS_1_0',
      ownership_verification_certificate_arn: 'test_ownership_verification_certificate_arn',
    ]
    mock_data[:mutual_tls_authentication] = {
      truststore_uri: 'test_truststore_uri',
      truststore_version: 'test_truststore_version',
      truststore_warnings: ['test_truststore_warnings'],
    }
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2DomainName.new(domain_name: 'test_domain_name', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.domain_name)
  end
  
  def test_domain_name_exists
    assert @res.exists?
  end

  def test_api_mapping_selection_expression
    assert_equal(@res.api_mapping_selection_expression, 'test_api_mapping_selection_expression')
  end

  def test_domain_name
    assert_equal(@res.domain_name, 'test_domain_name')
  end

  def test_api_gateway_domain_name
    assert_equal(@res.domain_name_configurations[0].api_gateway_domain_name, 'test_api_gateway_domain_name')
  end

  def test_api_gateway_domain_names
    assert_equal(@res.api_gateway_domain_names, ['test_api_gateway_domain_name'])
  end

  def test_certificate_arn
    assert_equal(@res.domain_name_configurations[0].certificate_arn, 'test_certificate_arn')
  end

  def test_certificate_arns
    assert_equal(@res.certificate_arns, ['test_certificate_arn'])
  end

  def test_certificate_name
    assert_equal(@res.domain_name_configurations[0].certificate_name, 'test_certificate_name')
  end

  def test_certificate_names
    assert_equal(@res.certificate_names, ['test_certificate_name'])
  end

  def test_certificate_upload_date
    assert_equal(@res.domain_name_configurations[0].certificate_upload_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_certificate_upload_dates
    assert_equal(@res.certificate_upload_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_domain_name_status
    assert_equal(@res.domain_name_configurations[0].domain_name_status, 'AVAILABLE')
  end

  def test_domain_name_statuses
    assert_equal(@res.domain_name_statuses, ['AVAILABLE'])
  end

  def test_domain_name_status_message
    assert_equal(@res.domain_name_configurations[0].domain_name_status_message, 'test_domain_name_status_message')
  end

  def test_domain_name_status_messages
    assert_equal(@res.domain_name_status_messages, ['test_domain_name_status_message'])
  end

  def test_endpoint_type
    assert_equal(@res.domain_name_configurations[0].endpoint_type, 'EDGE')
  end

  def test_endpoint_types
    assert_equal(@res.endpoint_types, ['EDGE'])
  end

  def test_hosted_zone_id
    assert_equal(@res.domain_name_configurations[0].hosted_zone_id, 'test_hosted_zone_id')
  end

  def test_hosted_zone_ids
    assert_equal(@res.hosted_zone_ids, ['test_hosted_zone_id'])
  end

  def test_security_policy
    assert_equal(@res.domain_name_configurations[0].security_policy, 'TLS_1_0')
  end

  def test_security_policies
    assert_equal(@res.security_policies, ['TLS_1_0'])
  end

  def test_ownership_verification_certificate_arn
    assert_equal(@res.domain_name_configurations[0].ownership_verification_certificate_arn, 'test_ownership_verification_certificate_arn')
  end

  def test_ownership_verification_certificate_arns
    assert_equal(@res.ownership_verification_certificate_arns, ['test_ownership_verification_certificate_arn'])
  end

  def test_truststore_uri
    assert_equal(@res.mutual_tls_authentication.truststore_uri, 'test_truststore_uri')
  end

  def test_truststore_version
    assert_equal(@res.mutual_tls_authentication.truststore_version, 'test_truststore_version')
  end

  def test_truststore_warnings
    assert_equal(@res.mutual_tls_authentication.truststore_warnings, ['test_truststore_warnings'])
  end

  def test_tags
    assert_equal(@res.tags, {})
  end
end
