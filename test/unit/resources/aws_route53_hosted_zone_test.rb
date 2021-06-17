require 'helper'
require 'aws_route53_hosted_zone'
require 'aws-sdk-core'

class AWSRoute53HostedZoneConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53HostedZone.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53HostedZone.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53HostedZone.new(unexpected: 9) }
  end
end

class AWSRoute53HostedZoneSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_hosted_zone
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:caller_reference] = 'test1'
    mock_data[:config] = {}
    mock_data[:resource_record_set_count] = 1
    mock_data[:linked_service] = {}
    data[:data] = { hosted_zone: mock_data }
    data[:client] = Aws::Route53::Client
    @hosted_zone = AWSRoute53HostedZone.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_hosted_zone_exists
    assert @hosted_zone.exists?
  end

  def test_id
    assert_equal(@hosted_zone.id, 'test1')
  end

  def test_name
    assert_equal(@hosted_zone.name, 'test1')
  end

  def test_caller_reference
    assert_equal(@hosted_zone.caller_reference, 'test1')
  end

  def test_config
    assert_equal(@hosted_zone.config, {})
  end

  def test_resource_record_set_count
    assert_equal(@hosted_zone.resource_record_set_count, 1)
  end

  def test_linked_service
    assert_equal(@hosted_zone.linked_service, {})
  end
end