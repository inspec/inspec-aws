require 'helper'
require 'aws_elasticloadbalancingv2_listener_certificates'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2ListenerCertificatesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSElasticLoadBalancingV2ListenerCertificates.new(listener_arn: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2ListenerCertificates.new('rubbish') }
  end

  def test_listener_certificates_non_existing_for_empty_response
    refute AWSElasticLoadBalancingV2ListenerCertificates.new(listener_arn: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSElasticLoadBalancingV2ListenerCertificatesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_listener_certificates
    mock_data = {}
    mock_data[:certificate_arn] = 'test1'
    mock_data[:is_default] = true
    data[:data] = { :certificates => [mock_data] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @listener_certificates = AWSElasticLoadBalancingV2ListenerCertificates.new(listener_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_certificates_exists
    assert @listener_certificates.exist?
  end

  def test_certificate_arns
    assert_equal(@listener_certificates.certificate_arns, ['test1'])
  end

  def test_is_defaults
    assert_equal(@listener_certificates.is_defaults, [true])
  end
end