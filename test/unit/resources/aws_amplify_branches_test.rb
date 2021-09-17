require 'helper'
require 'aws_amplify_branches'
require 'aws-sdk-core'

class AWSAmplifyBranchesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(app_id: '', branch_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAmplifyBranches.new(unexpected: 9) }
  end
end

class AWSAmplifyBranchesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_app
    mock_parameter = {}
    mock_parameter[:branch_arn] = 'test1'
    mock_parameter[:branch_name] = 'test1'
    mock_parameter[:description] = 'test1'
    mock_parameter[:tags] = 'test1'
    mock_parameter[:tags] = 'test1'
    mock_parameter[:display_name] = 'test1'
    mock_parameter[:create_time] = Time.now
    mock_parameter[:update_time] = Time.now
    mock_parameter[:environment_variables] = { "value" => 'test1'}
    mock_parameter[:custom_domains] = 'test1'
    mock_parameter[:enable_basic_auth] = true
    mock_parameter[:source_branch] = false
    data[:data] = { app: mock_parameter }
    data[:client] = Aws::Amplify::Client
    @amplify = AWSAmplifyBranches.new(app_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_branch_exists
    assert @amplify.exists?
  end

  def test_branch_arns
    assert_equal(@amplify.branch_arns, ['test1'])
  end

  def test_branch_names
    assert_equal(@amplify.branch_names, ['test1'])
  end
end


