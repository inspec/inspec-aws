require 'helper'
require 'aws_batch_job_definition'
require 'aws-sdk-core'

class AWSBatchJobDefinitionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSBatchJobDefinition.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSBatchJobDefinition.new(compute_environment_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSBatchJobDefinition.new(unexpected: 9) }
  end
end

class AWSBatchJobDefinitionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_job_definitions
    mock_parameter = {}
    mock_parameter[:job_definition_name] = 'test1'
    mock_parameter[:job_definition_arn] = 'test1'
    mock_parameter[:revision] = 1
    mock_parameter[:status] = 'test1'
    mock_parameter[:type] = 'test1'
    # mock_parameter[:parameters] = 1
    # mock_parameter[:container_properties] = 'test1'
    # mock_parameter[:timeout] = 'test1'
    # mock_parameter[:node_properties] = 'test1'
    # mock_parameter[:tags] = 'test1'
    mock_parameter[:propagate_tags] = true
    mock_parameter[:platform_capabilities] = ['test1']
    data[:data] = { job_definitions: [mock_parameter] }
    data[:client] = Aws::Batch::Client
    @job_definitions = AWSBatchJobDefinition.new(job_definition_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_job_definitions_exists
    assert @job_definitions.exists?
  end

  def test_job_definition_name
    assert_equal(@job_definitions.job_definition_name, 'test1')
  end

  def test_revision
    assert_equal(@job_definitions.revision, 1)
  end

  def test_status
    assert_equal(@job_definitions.status, 'test1')
  end

  def test_propagate_tags
    assert_equal(@job_definitions.propagate_tags, true)
  end

  def test_platform_capabilities
    assert_equal(@job_definitions.platform_capabilities, ['test1'])
  end

  def test_resource_id
    refute_nil(@job_definitions.resource_id)
    assert_equal(@job_definitions.resource_id, 'test1')
  end
end