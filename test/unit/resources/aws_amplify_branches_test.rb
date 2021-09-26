require 'helper'
require 'aws_amplify_branches'
require 'aws-sdk-core'

class AWSAmplifyBranchesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(app_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(unexpected: 9) }
  end
end

class AWSAmplifyBranchesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_branches
    mock_parameter = {}
    mock_parameter[:branch_arn] = 'test1'
    mock_parameter[:branch_name] = 'test1'
    mock_parameter[:description] = 'test1'
    mock_parameter[:tags] = { "value" => 'test1'}
    mock_parameter[:display_name] = 'test1'
    mock_parameter[:create_time] = Time.now
    mock_parameter[:update_time] = Time.now
    mock_parameter[:environment_variables] = { "value" => 'test1'}
    mock_parameter[:enable_basic_auth] = true
    mock_parameter[:source_branch] = 'test1'
    mock_parameter[:stage] = 'test1'
    mock_parameter[:enable_notification] = true
    mock_parameter[:enable_auto_build] = false
    mock_parameter[:framework] = 'test1'
    mock_parameter[:active_job_id] = 'test1'
    mock_parameter[:total_number_of_jobs] = "1"
    mock_parameter[:ttl] = 'test1'
    mock_parameter[:enable_pull_request_preview] = true
    mock_parameter[:custom_domains] = ['test1']
    data[:data] = { :branches => [mock_parameter] }
    data[:client] = Aws::Amplify::Client
    @resp = AWSAmplifyBranches.new(app_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_branch_exists
    assert @resp.exists?
  end

  def test_branch_arns
    assert_equal(@resp.branch_arns, ['test1'])
  end

  def test_branch_names
    assert_equal(@resp.branch_names, ['test1'])
  end
end


