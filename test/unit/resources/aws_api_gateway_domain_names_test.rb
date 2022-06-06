require 'helper'
require 'aws_api_gateway_domain_names'
require 'aws-sdk-core'

class AWSApiGatewayDomainNamesConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayDomainNames.new(unexpected: 9) }
  end
end

class AWSApiGatewayDomainNamesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_domain_names
    mock_data = {}
    mock_data[:domain_name] = 'test'
    mock_data[:certificate_name] = 'test'
    mock_data[:certificate_arn] = 'test'
    mock_data[:certificate_upload_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:regional_domain_name] = 'test'
    mock_data[:regional_hosted_zone_id] = 'test'
    mock_data[:regional_certificate_name] = 'test'
    mock_data[:regional_certificate_arn] = 'test'
    mock_data[:distribution_domain_name] = 'test'
    mock_data[:distribution_hosted_zone_id] = 'test'
    mock_data[:endpoint_configuration] = {
      types: ['test'],
      vpc_endpoint_ids: ['test']
    }
    mock_data[:domain_name_status] = 'test'
    mock_data[:domain_name_status_message] = 'test'
    mock_data[:security_policy] = 'test'
    mock_data[:tags] = {}
    mock_data[:mutual_tls_authentication] = {}
    mock_data[:ownership_verification_certificate_arn] = 'test'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayDomainNames.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_name_exists
    assert @res.exists?
  end

  def test_domain_names
    assert_equal(@res.domain_names, ['test'])
  end

  def test_certificate_names
    assert_equal(@res.certificate_names, ['test'])
  end

  def test_certificate_arns
    assert_equal(@res.certificate_arns, ['test'])
  end

  def test_certificate_upload_dates
    assert_equal(@res.certificate_upload_dates, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_regional_domain_names
    assert_equal(@res.regional_domain_names, ['test'])
  end

  def test_regional_hosted_zone_ids
    assert_equal(@res.regional_hosted_zone_ids, ['test'])
  end

  def test_regional_certificate_names
    assert_equal(@res.regional_certificate_names, ['test'])
  end

  def test_regional_certificate_arns
    assert_equal(@res.regional_certificate_arns, ['test'])
  end

  def test_distribution_domain_names
    assert_equal(@res.distribution_domain_names, ['test'])
  end

  def test_distribution_hosted_zone_ids
    assert_equal(@res.distribution_hosted_zone_ids, ['test'])
  end

  def test_domain_name_statuses
    assert_equal(@res.domain_name_statuses, ['test'])
  end

  def test_domain_name_status_messages
    assert_equal(@res.domain_name_status_messages, ['test'])
  end

  def test_security_policies
    assert_equal(@res.security_policies, ['test'])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end

  def test_mutual_tls_authentications
    assert_equal(@res.mutual_tls_authentications, [{}])
  end

  def test_ownership_verification_certificate_arns
    assert_equal(@res.ownership_verification_certificate_arns, ['test'])
  end
end