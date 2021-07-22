require 'helper'
require 'aws_transfer_users'
require 'aws-sdk-core'

class AWSTransferUsersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSTransferUsers.new(server_id: "test1", client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSTransferUsers.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSTransferUsers.new(server_id: "test1", client_args: { stub_responses: true }).exist?
  end
end

class AWSTransferUsersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_users
    mock_data = {}
    mock_data[:arn] = 'test1'
    mock_data[:home_directory] = 'test1'
    data[:data] = { :users => [mock_data], server_id: "test1"  }
    data[:client] = Aws::Transfer::Client
    @users = AWSTransferUsers.new(server_id: "default", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_users_exists
    assert @users.exist?
  end

  def test_arns
    assert_equal(@users.arns, ['test1'])
  end

  def test_home_directories
    assert_equal(@users.home_directories, ['test1'])
  end
end