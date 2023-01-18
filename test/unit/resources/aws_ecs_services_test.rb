require 'helper'
require 'aws_ecs_services'
require 'aws-sdk-core'

class AWSECSServicesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSECSServices.new(cluster: "test1", client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSECSServices.new('rubbish') }
  end
end

class AWSECSServicesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_services
    mock_data = {}
    mock_data[:service_arn] = 'test1'
    data[:data] = {services: [ mock_data] }
    data[:client] = Aws::ECS::Client
    @resp = AWSECSServices.new(cluster: "test1", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_service_exists
    assert @resp.exist?
  end

  def test_names

    assert_equal(@resp.service_arns, ['test1'])
  end
end