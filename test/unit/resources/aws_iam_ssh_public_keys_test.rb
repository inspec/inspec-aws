require 'helper'
require 'aws_iam_ssh_public_keys'
require 'aws-sdk-core'

class AWSIAMSSHPublicKeysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSIAMSSHPublicKeys.new(user_name: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSIAMSSHPublicKeys.new('rubbish') }
  end

  def test_ssh_public_keys_non_existing_for_empty_response
    refute AWSIAMSSHPublicKeys.new(user_name: 'test', client_args: { stub_responses: true }).exist?
  end
end

class AWSIAMSSHPublicKeysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_ssh_public_keys
    mock_data = {}
    mock_data[:user_name] = 'test1'
    mock_data[:ssh_public_key_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:upload_date] = Time.now
    data[:data] = { :ssh_public_keys => [mock_data] }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMSSHPublicKeys.new(user_name: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssh_public_keys_exists
    assert @resp.exists?
  end

  def test_ssh_public_keys_available
    assert @resp.available?
  end

  def test_user_names
    assert_equal(@resp.user_names, ['test1'])
  end

  def test_ssh_public_key_ids
    assert_equal(@resp.ssh_public_key_ids, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end
end

class AWSIAMSSHPublicKeysWithNoParametersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_ssh_public_keys
    mock_data = {}
    mock_data[:user_name] = 'test1'
    mock_data[:ssh_public_key_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:upload_date] = Time.now
    data[:data] = { :ssh_public_keys => [mock_data] }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMSSHPublicKeys.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssh_public_keys_exists
    assert @resp.exists?
  end

  def test_ssh_public_keys_available
    assert @resp.available?
  end

  def test_user_names
    assert_equal(@resp.user_names, ['test1'])
  end

  def test_ssh_public_key_ids
    assert_equal(@resp.ssh_public_key_ids, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end
end