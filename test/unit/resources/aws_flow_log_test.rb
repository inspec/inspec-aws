require 'helper'
require 'aws_flow_log'
require 'aws-sdk-core'

class AwsFlowLogConstructorTest < Minitest::Test

  def test_rejects_empty_params
    assert_raises(ArgumentError) { AwsFlowLog.new }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsFlowLog.new(rubbish: 9) }
  end

  def test_flow_log_non_existing
    refute AwsFlowLog.new(flow_log_id: 'flow_log-1234abcd', client_args: { stub_responses: true }).exists?
  end

  def test_flow_log_non_existing_vpc
    refute AwsFlowLog.new(vpc_id: 'vpc-1234abcd', client_args: { stub_responses: true }).exists?
  end

  def test_flow_log_non_existing_subnet
    refute AwsFlowLog.new(subnet_id: 'subnet-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsFlowLogTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_flow_logs
    flow_log = {}
    flow_log[:flow_log_id] = 'flow_log-12345678'
    flow_log[:log_group_name] = 'log-group-name'
    flow_log[:resource_id] = 'vpc-12345678'
    data[:data] = { :flow_logs => [flow_log] }
    data[:client] = Aws::EC2::Client
    @flow_log = AwsFlowLog.new(flow_log_id: 'flow_log-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_flow_log_exists
    assert @flow_log.exists?
  end

  def test_flow_log_id
    assert_equal(@flow_log.flow_log_id, 'flow_log-12345678')
  end

  def test_flow_log_log_group_name
    assert_equal(@flow_log.log_group_name, 'log-group-name')
  end

  def test_flow_log_resource_id
    assert_equal(@flow_log.resource_id, 'vpc-12345678')
  end

  def test_flow_log_resource_type
    assert_equal(@flow_log.resource_type, 'vpc')
  end

  def test_attached_vpc
    assert @flow_log.attached_to_vpc?
    refute @flow_log.attached_to_subnet?
    refute @flow_log.attached_to_eni?
  end

  def test_id_method
    assert_equal(@flow_log.send(:id), 'flow_log-12345678')
  end
end