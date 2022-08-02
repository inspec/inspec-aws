require 'helper'
require 'aws_transfer_user'
require 'aws-sdk-core'

class AWSTransferUserConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransferUser.new(server_id: '', user_name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransferUser.new(server_id: '', user_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransferUser.new(unexpected: 9) }
  end
end

class AWSTransferUserSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_user
    mock_data = {}
    mock_data[:arn] = 'test1'
    mock_data[:home_directory] = 'test1'
    mock_data[:home_directory_type] = 'test1'
    mock_data[:policy] = 'test1'
    mock_data[:role] = 'test1'
    mock_data[:tags] = []
    mock_data[:user_name] = 'test1'
    data[:data] = { user: mock_data, server_id: "test1" }
    data[:client] = Aws::Transfer::Client
    @user = AWSTransferUser.new(server_id: 'test1', user_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_exists
    assert @user.exists?
  end

  def test_server_id
    assert_equal(@user.server_id, 'test1')
  end

  def test_arn
    assert_equal(@user.arn, 'test1')
  end

  def test_home_directory
    assert_equal(@user.home_directory, 'test1')
  end

  def test_home_directory_type
    assert_equal(@user.home_directory_type, 'test1')
  end

  def test_policy
    assert_equal(@user.policy, 'test1')
  end

  def test_role
    assert_equal(@user.role, 'test1')
  end

  def test_user_name
    assert_equal(@user.user_name, 'test1')
  end

  def test_resource_id
    refute_nil(@user.resource_id)
    assert_equal(@user.resource_id, 'test1')
  end
end