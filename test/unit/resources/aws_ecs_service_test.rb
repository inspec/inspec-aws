require 'helper'
require 'aws_ecs_service'
require 'aws-sdk-core'

class AWSECSServiceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSECSService.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSECSService.new(cluster: '', service: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSECSService.new(unexpected: 9) }
  end
end

class AWSECSServiceSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_services
    mock_parameter = {}
    mock_parameter[:service_arn] = 'test1'
    mock_parameter[:service_name] = 'test1'
    mock_parameter[:cluster_arn] = 'test1'
    data[:data] = { services: [mock_parameter] }
    data[:client] = Aws::ECS::Client
    @work_group = AWSECSService.new(cluster: 'test1', service: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @work_group.exists?
  end

  def test_service_arn
    assert_equal(@work_group.service_arn, 'test1')
  end

  def test_service_name
    assert_equal(@work_group.service_name, 'test1')
  end

  def test_cluster_arn
    assert_equal(@work_group.cluster_arn, 'test1')
  end
end