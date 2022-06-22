require 'helper'
require 'aws_amplify_branch'
require 'aws-sdk-core'

class AWSAmplifyBranchConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(app_id: '', branch_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(unexpected: 9) }
  end
end

class AWSAmplifyBranchSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_branch
    mock_parameter = {}
    mock_parameter[:branch_arn] = 'test1'
    mock_parameter[:branch_name] = 'test1'
    mock_parameter[:description] = 'test1'
    mock_parameter[:tags] = {"type" =>'test1'}
    mock_parameter[:display_name] = 'test1'
    mock_parameter[:create_time] = Time.now
    mock_parameter[:update_time] = Time.now
    mock_parameter[:environment_variables] = { "value" => 'test1'}
    mock_parameter[:custom_domains] = ['test1']
    mock_parameter[:enable_basic_auth] = true
    mock_parameter[:source_branch] = "false"
    mock_parameter[:stage] = 'test1'
    mock_parameter[:enable_notification] = true
    mock_parameter[:enable_auto_build] = false
    mock_parameter[:framework] = 'test1'
    mock_parameter[:active_job_id] = 'test1'
    mock_parameter[:total_number_of_jobs] = "1"
    mock_parameter[:ttl] = 'test1'
    mock_parameter[:enable_pull_request_preview] = true
    data[:data] = { branch: mock_parameter }
    data[:client] = Aws::Amplify::Client
    @resp = AWSAmplifyBranch.new(app_id: 'test1', branch_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_branch_exists
    assert @resp.exists?
  end

  def test_branch_arn
    assert_equal(@resp.branch_arn, 'test1')
  end

  def test_branch_name
    assert_equal(@resp.branch_name, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end

