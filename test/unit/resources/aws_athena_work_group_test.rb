require 'helper'
require 'aws_athena_work_group'
require 'aws-sdk-core'

class AWSAthenaWorkGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAthenaWorkGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAthenaWorkGroup.new(work_group: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAthenaWorkGroup.new(unexpected: 9) }
  end
end

class AWSAthenaWorkGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_work_group
    mock_parameter = {}
    mock_parameter[:name] = 'test1'
    mock_parameter[:state] = 'test1'
    mock_parameter[:description] = 'test1'
    data[:data] = { work_group: mock_parameter }
    data[:client] = Aws::Athena::Client
    @work_group = AWSAthenaWorkGroup.new(work_group: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @work_group.exists?
  end

  def test_name
    assert_equal(@work_group.name, 'test1')
  end

  def test_state
    assert_equal(@work_group.state, 'test1')
  end

  def test_description
    assert_equal(@work_group.description, 'test1')
  end

  def test_resource_id
    refute_nil(@work_group.resource_id)
    assert_equal(@work_group.resource_id, 'test1')
  end
end