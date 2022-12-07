require 'helper'
require 'aws_elasticloadbalancingv2_listener_certificate'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenerCertificateConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerCertificate.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerCertificate.new(listener_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerCertificate.new(unexpected: 9) }
  end
end

class AWSElasticLoadBalancingV2ListenerCertificateSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_listener_certificates
    mock_parameter = {}
    mock_parameter[:certificate_arn] = 'test1'
    mock_parameter[:is_default] = true
    data[:data] = { certificates: [mock_parameter] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @certificates = AWSElasticLoadBalancingV2ListenerCertificate.new(listener_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_certificates_exists
    assert @certificates.exists?
  end

  def test_certificate_arn
    assert_equal(@certificates.certificate_arn, 'test1')
  end

  def test_is_default
    assert_equal(@certificates.is_default, true)
  end

  def test_resource_id
    refute_nil(@certificates.resource_id)
    assert_equal(@certificates.resource_id, 'test1')
  end
end