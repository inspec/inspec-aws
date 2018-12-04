require 'helper'
require 'aws_kms_key'
require 'aws-sdk-core'

class AwsKmsKeyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsKmsKey.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_key_arn_as_hash
    AwsKmsKey.new(key_id: 'arn:aws:kms:us-east-1::key/7a6950aa-c8e6-4e51-8afc-111111111111', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsKmsKey.new(rubbish: 9) }
  end

  def test_key_non_existing
    not_found = {}
    not_found[:client] = Aws::KMS::Client
    not_found[:data] = {}
    not_found[:method] = :describe_key
    refute AwsKmsKey.new(key_id: 'key-1234abcd', client_args: { stub_responses: true }, stub_data: [not_found]).exists?
  end
end

class AwsKmsKeyHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_key
    mock_key = {}
    mock_key[:aws_account_id] = '468368903678'
    mock_key[:key_id] = '6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'
    mock_key[:arn] = 'arn:aws:kms:eu-west-2:510367013858:key/6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'
    mock_key[:creation_date] = Time.now - 10 * 24 * 3600
    mock_key[:enabled] = true
    mock_key[:description] = 'InSpec'
    mock_key[:key_usage] = 'ENCRYPT_DECRYPT'
    mock_key[:key_state] = 'Enabled'
    mock_key[:origin] = 'AWS_KMS'
    mock_key[:key_manager] = 'CUSTOMER'
    data[:data] = { :key_metadata => mock_key }
    data[:client] = Aws::KMS::Client
    key_rotn = {}
    key_rotn[:method] = :get_key_rotation_status
    key_rotn[:data] = { :key_rotation_enabled => true }
    key_rotn[:client] = Aws::KMS::Client
    @kms_key = AwsKmsKey.new(key_id: '6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3', client_args: { stub_responses: true }, stub_data: [data, key_rotn])
  end

  def test_key_exists
    assert @kms_key.exists?
  end

  def test_key_enabled
    assert @kms_key.enabled?
  end

  def test_key_rotation_enabled
    assert @kms_key.has_rotation_enabled?
  end

  def test_key_external
    refute @kms_key.external?
  end

  def test_kms_key_aws_account_id
    assert_equal(@kms_key.aws_account_id, '468368903678')
  end

  def test_kms_key_key_id
    assert_equal(@kms_key.key_id, '6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3')
  end

  def test_kms_key_arn
    assert_equal(@kms_key.arn, 'arn:aws:kms:eu-west-2:510367013858:key/6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3')
  end

  def test_kms_key_creation_date
    assert_equal(@kms_key.created_days_ago, 10)
  end

  def test_kms_key_enabled
    assert_equal(@kms_key.enabled, true)
  end

  def test_kms_key_description
    assert_equal(@kms_key.description, 'InSpec')
  end

  def test_kms_key_key_usage
    assert_equal(@kms_key.key_usage, 'ENCRYPT_DECRYPT')
  end

  def test_kms_key_key_state
    assert_equal(@kms_key.key_state, 'Enabled')
  end

  def test_kms_key_origin
    assert_equal(@kms_key.origin, 'AWS_KMS')
  end

  def test_kms_key_key_manager
    assert_equal(@kms_key.key_manager, 'CUSTOMER')
  end

end


class AwsKmsKeyOtherPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_key
    mock_key = {}
    mock_key[:key_id] = '9f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'
    mock_key[:arn] = 'arn:aws:kms:eu-west-2:510367013858:key/6f9df98b-cb3d-4b3a-8fcb-aa892a9345e9'
    mock_key[:creation_date] = Time.now - 10 * 24 * 3600
    mock_key[:enabled] = false
    mock_key[:description] = 'InSpec'
    mock_key[:key_usage] = 'ENCRYPT_DECRYPT'
    mock_key[:key_state] = 'Enabled'
    mock_key[:origin] = 'EXTERNAL'
    mock_key[:key_manager] = 'AWS'
    mock_key[:expiration_model] = 'KEY_MATERIAL_EXPIRES'
    data[:data] = { :key_metadata => mock_key }
    data[:client] = Aws::KMS::Client
    key_rotn = {}
    key_rotn[:method] = :get_key_rotation_status
    key_rotn[:data] = { :key_rotation_enabled => false }
    key_rotn[:client] = Aws::KMS::Client
    @kms_key = AwsKmsKey.new(key_id: '9f9df98b-cb3d-4b3a-8fcb-aa892a9345e3', client_args: { stub_responses: true }, stub_data: [data, key_rotn])
  end

  def test_key_exists
    assert @kms_key.exists?
  end

  def test_key_enabled
    refute @kms_key.enabled?
  end

  def test_key_rotation_enabled
    refute @kms_key.has_rotation_enabled?
  end

  def test_key_external
    assert @kms_key.external?
  end

  def test_kms_key_enabled
    refute @kms_key.enabled?
  end

  def test_aws_managed
    assert @kms_key.managed_by_aws?
  end

  def test_expiration
    assert @kms_key.has_key_expiration?
  end

end