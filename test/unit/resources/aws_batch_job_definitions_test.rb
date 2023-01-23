require 'helper'
require 'aws_batch_job_definitions'
require 'aws-sdk-core'

class AWSBatchJobDefinitionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSBatchJobDefinitions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSBatchJobDefinitions.new('rubbish') }
  end

  def test_job_definitions_non_existing_for_empty_response
    refute AWSBatchJobDefinitions.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSBatchJobDefinitionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_job_definitions
    mock_parameter = {}
    mock_parameter[:job_definition_name] = 'test1'
    mock_parameter[:job_definition_arn] = 'test1'
    mock_parameter[:revision] = 1
    mock_parameter[:status] = 'test1'
    mock_parameter[:type] = 'test1'
    mock_parameter[:propagate_tags] = true
    mock_parameter[:platform_capabilities] = ['test1']
    data[:data] = { job_definitions: [mock_parameter] }
    data[:client] = Aws::Batch::Client
    @job_definitions = AWSBatchJobDefinitions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_job_definitions_exists
    assert @job_definitions.exists?
  end

  def test_job_definition_names
    assert_equal(@job_definitions.job_definition_names, ['test1'])
  end

  def test_job_definition_arns
    assert_equal(@job_definitions.job_definition_arns, ['test1'])
  end

  def test_revisions
    assert_equal(@job_definitions.revisions, [1])
  end

  def test_statuses
    assert_equal(@job_definitions.statuses, ['test1'])
  end

  def test_propagate_tags
    assert_equal(@job_definitions.propagate_tags, [true])
  end

  def test_platform_capabilities
    assert_equal(@job_definitions.platform_capabilities, [['test1']])
  end
end