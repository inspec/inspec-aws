require 'helper'
require 'aws_api_gateway_domain_name'
require 'aws-sdk-core'

class AWSApiGatewayDomainNameConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayDomainName.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayDomainName.new(domain_name: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayDomainName.new(unexpected: 9) }
  end
end

class AWSApiGatewayDomainNameSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_domain_name
    mock_data = {}
    mock_data[:domain_name] = 'test_domain_name'
    mock_data[:certificate_name] = 'test_certificate_name'
    mock_data[:certificate_arn] = 'test_certificate_arn'
    mock_data[:certificate_upload_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:regional_domain_name] = 'test_regional_domain_name'
    mock_data[:regional_hosted_zone_id] = 'test_regional_hosted_zone_id'
    mock_data[:regional_certificate_name] = 'test_regional_certificate_name'
    mock_data[:regional_certificate_arn] = 'test_regional_certificate_arn'
    mock_data[:distribution_domain_name] = 'test_distribution_domain_name'
    mock_data[:distribution_hosted_zone_id] = 'test_distribution_hosted_zone_id'
    mock_data[:endpoint_configuration] = {
      types: ['test_type'],
      vpc_endpoint_ids: ['test_vpc_endpoint_id']
    }
    mock_data[:domain_name_status] = 'test_domain_name_status'
    mock_data[:domain_name_status_message] = 'test_domain_name_status_message'
    mock_data[:security_policy] = 'test_security_policy'
    mock_data[:tags] = {}
    mock_data[:mutual_tls_authentication] = {
      truststore_uri: 'test_truststore_uri',
      truststore_version: 'test_truststore_version',
      truststore_warnings: ['test_truststore_warning'],
    }
    mock_data[:ownership_verification_certificate_arn] = 'test_ownership_verification_certificate_arn'
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayDomainName.new(domain_name: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.domain_name+'_'+@res.certificate_arn)
  end
  
  def test_domain_name_exists
    assert @res.exists?
  end
  
  def test_domain_name
    assert_equal(@res.domain_name, 'test_domain_name')
  end
  
  def test_certificate_name
    assert_equal(@res.certificate_name, 'test_certificate_name')
  end
  
  def test_certificate_arn
    assert_equal(@res.certificate_arn, 'test_certificate_arn')
  end
  
  def test_certificate_upload_date
    assert_equal(@res.certificate_upload_date, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
  
  def test_regional_domain_name
    assert_equal(@res.regional_domain_name, 'test_regional_domain_name')
  end
  
  def test_regional_hosted_zone_id
    assert_equal(@res.regional_hosted_zone_id, 'test_regional_hosted_zone_id')
  end
  
  def test_regional_certificate_name
    assert_equal(@res.regional_certificate_name, 'test_regional_certificate_name')
  end
  
  def test_regional_certificate_arn
    assert_equal(@res.regional_certificate_arn, 'test_regional_certificate_arn')
  end
  
  def test_distribution_domain_name
    assert_equal(@res.distribution_domain_name, 'test_distribution_domain_name')
  end
  
  def test_distribution_hosted_zone_id
    assert_equal(@res.distribution_hosted_zone_id, 'test_distribution_hosted_zone_id')
  end
  
  def test_endpoint_configuration_types
    assert_equal(@res.endpoint_configuration.types, ['test_type'])
  end
  
  def test_endpoint_configuration_vpc_endpoint_ids
    assert_equal(@res.endpoint_configuration.vpc_endpoint_ids, ['test_vpc_endpoint_id'])
  end
  
  def test_domain_name_status
    assert_equal(@res.domain_name_status, 'test_domain_name_status')
  end
  
  def test_domain_name_status_message
    assert_equal(@res.domain_name_status_message, 'test_domain_name_status_message')
  end
  
  def test_security_policy
    assert_equal(@res.security_policy, 'test_security_policy')
  end
  
  def test_tags
    assert_equal(@res.tags, {})
  end
  
  def test_mutual_tls_authentication_truststore_uri
    assert_equal(@res.mutual_tls_authentication.truststore_uri, 'test_truststore_uri')
  end
  
  def test_mutual_tls_authentication_truststore_version
    assert_equal(@res.mutual_tls_authentication.truststore_version, 'test_truststore_version')
  end
  
  def test_mutual_tls_authentication_truststore_warnings
    assert_equal(@res.mutual_tls_authentication.truststore_warnings, ['test_truststore_warning'])
  end
  
  def test_ownership_verification_certificate_arn
    assert_equal(@res.ownership_verification_certificate_arn, 'test_ownership_verification_certificate_arn')
  end
end
