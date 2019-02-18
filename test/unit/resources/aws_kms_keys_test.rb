require 'helper'
require 'aws_kms_keys'
require 'aws-sdk-core'

class AwsKmsKeysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsKmsKeys.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsKmsKeys.new('rubbish') }
  end

  def test_kms_keys_non_existing_for_empty_response
    refute AwsKmsKeys.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsKmsKeysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_keys
    mock_key = {}
    mock_key[:key_id] = '6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'
    mock_key[:key_arn] = 'arn:aws:kms:eu-west-2:510367013858:key/6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'
    data[:data] = { :keys => [mock_key] }
    data[:client] = Aws::KMS::Client
    @keys = AwsKmsKeys.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_keys_exists
    assert @keys.exist?
  end

  def test_keys_ids
    assert_equal(@keys.key_ids, ['6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'])
  end

  def test_keys_arns
    assert_equal(@keys.key_arns, ['arn:aws:kms:eu-west-2:510367013858:key/6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3'])
  end

  def test_keys_filtering_not_there
    refute @keys.where(:key_id => 'bad').exist?
  end

  def test_keys_filtering_there
    assert @keys.where(:key_id => '6f9df98b-cb3d-4b3a-8fcb-aa892a9345e3').exist?
  end
end