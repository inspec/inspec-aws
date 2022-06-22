require 'helper'
require 'aws_elasticloadbalancingv2_target_group'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2TargetGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2TargetGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2TargetGroup.new(target_group_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2TargetGroup.new(unexpected: 9) }
  end
end

class AWSElasticLoadBalancingV2TargetGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_target_groups
    mock_parameter = {}
    mock_parameter[:target_group_arn] = 'test1'
    mock_parameter[:target_group_name] = 'test1'
    mock_parameter[:protocol] = 'test1'
    data[:data] = { target_groups: [mock_parameter] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @target_groups = AWSElasticLoadBalancingV2TargetGroup.new(target_group_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @target_groups.exists?
  end

  def test_target_group_arn
    assert_equal(@target_groups.target_group_arn, 'test1')
  end

  def test_target_group_name
    assert_equal(@target_groups.target_group_name, 'test1')
  end

  def test_protocol
    assert_equal(@target_groups.protocol, 'test1')
  end

  def test_resource_id
    refute_nil(@target_groups.resource_id)
    assert_equal(@target_groups.resource_id, 'test1')
  end

end