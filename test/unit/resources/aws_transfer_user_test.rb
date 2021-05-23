require 'helper'
require 'aws_transfer_user'
require 'aws-sdk-core'

class AWSTransferUserConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransferUser.new(client_args: { stub_responses: true }) }
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
    mock_parameter = {}
    mock_parameter[:server_id] = 'test1'
    data[:data] = [mock_parameter]
    data[:client] = Aws::Transfer::Client
    @users = AWSTransferUser.new(server_id: 'test1', user_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_user_exists
    assert @users.exists?
  end

  def test_server_id
    assert_equal(@users.server_id, 'test1')
  end
end