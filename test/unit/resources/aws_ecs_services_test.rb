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
    data[:method] = :list_services
    mock_data = {}
    mock_data[:service_arns] = ['test1']
    data[:data] = mock_data
    data[:client] = Aws::ECS::Client
    @res = AWSECSServices.new(cluster: "test1", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_service_exists
    assert @res.exist?
  end

  def test_names
    assert_equal(@res.service_arns, [['test1']])
  end
end