require 'helper'
require 'aws_iam_ssh_public_key'
require 'aws-sdk-core'

class AWSIAMSSHPublicKeyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSIAMSSHPublicKey.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSIAMSSHPublicKey.new(user_name: '', ssh_public_key_id: '', encoding: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSIAMSSHPublicKey.new(unexpected: 9) }
  end
end

class AWSIAMSSHPublicKeySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_ssh_public_key
    mock_data = {}
    mock_data[:user_name] = 'test1'
    mock_data[:ssh_public_key_id] = 'test1'
    mock_data[:fingerprint] = 'test1'
    mock_data[:ssh_public_key_body] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:upload_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    data[:data] = { ssh_public_key: mock_data }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMSSHPublicKey.new(user_name: 'test1', ssh_public_key_id: 'test1', encoding: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssh_public_keys_exists
    assert @resp.exists?
  end

  def test_user_name
    assert_equal(@resp.user_name, 'test1')
  end

  def test_ssh_public_key_id
    assert_equal(@resp.ssh_public_key_id, 'test1')
  end

  def test_fingerprint
    assert_equal(@resp.fingerprint, 'test1')
  end

  def test_ssh_public_key_body
    assert_equal(@resp.ssh_public_key_body, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_upload_date
    assert_equal(@resp.upload_date, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end
end
