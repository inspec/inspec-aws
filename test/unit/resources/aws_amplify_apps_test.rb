require 'helper'
require 'aws_amplify_apps'
require 'aws-sdk-core'

class AWSAmplifyAppsConstructorTest < Minitest::Test

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAmplifyApps.new(app_id: 'random', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAmplifyApps.new(unexpected: 9) }
  end
end

class AWSAmplifyAppsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_apps
    mock_parameter = {}
    mock_parameter[:app_arn] = 'test1'
    mock_parameter[:app_id] = 'test1'
    mock_parameter[:name] = 'test1'
    mock_parameter[:description] = 'test1'
    mock_parameter[:repository] = 'test1'
    mock_parameter[:platform] = 'test1'
    mock_parameter[:create_time] = Time.now
    mock_parameter[:update_time] = Time.now
    mock_parameter[:environment_variables] = { "value" => 'test1'}
    mock_parameter[:default_domain] = 'test1'
    mock_parameter[:enable_branch_auto_build] = true
    mock_parameter[:enable_basic_auth] = false
    data[:data] = { apps: [mock_parameter] }
    data[:client] = Aws::Amplify::Client
    @mq_app = AWSAmplifyApps.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_amplify_app_exists
    assert @mq_app.exists?
  end

  def test_amplify_app_arn
    assert_equal(@mq_app.app_arns, ['test1'])
  end

  def test_amplify_app_name
    assert_equal(@mq_app.names, ['test1'])
  end
end
