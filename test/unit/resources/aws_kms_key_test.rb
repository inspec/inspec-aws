require 'helper'
require 'aws_kms_key'
require 'aws-sdk-core'
require_relative 'mock/aws_kms_key_mock'

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
    # Given
    @mock = AwsKmsKeyMock.new
    @mock_kms_key = @mock.enabled_kms

    # When
    @kms_key = AwsKmsKey.new(key_id: @mock_kms_key[:key_id],
                            client_args: { stub_responses: true },
                            stub_data: @mock.stub_data_enabled)
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
    assert_equal(@kms_key.aws_account_id, @mock_kms_key[:aws_account_id])
  end

  def test_kms_key_key_id
    assert_equal(@kms_key.key_id, @mock_kms_key[:key_id])
  end

  def test_kms_key_arn
    assert_equal(@kms_key.arn, @mock_kms_key[:arn])
  end

  def test_kms_key_creation_date
    assert_equal(@kms_key.created_days_ago, ((Time.now - @mock_kms_key[:creation_date]) / (24 * 60 * 60)).to_i)
  end

  def test_kms_key_enabled
    assert_equal(@kms_key.enabled, @mock_kms_key[:enabled])
  end

  def test_kms_key_description
    assert_equal(@kms_key.description, @mock_kms_key[:description])
  end

  def test_kms_key_key_usage
    assert_equal(@kms_key.key_usage, @mock_kms_key[:key_usage])
  end

  def test_kms_key_key_state
    assert_equal(@kms_key.key_state, @mock_kms_key[:key_state])
  end

  def test_kms_key_origin
    assert_equal(@kms_key.origin, @mock_kms_key[:origin])
  end

  def test_kms_key_key_manager
    assert_equal(@kms_key.key_manager, @mock_kms_key[:key_manager])
  end

end


class AwsKmsKeyOtherPathTest < Minitest::Test

  def setup
    # Given
    @mock = AwsKmsKeyMock.new
    @mock_kms_key = @mock.disabled_kms

    # When
    @kms_key = AwsKmsKey.new(key_id: @mock_kms_key[:key_id],
                                   client_args: { stub_responses: true },
                                   stub_data: @mock.stub_data_disabled)
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

class AwsKmsKeyAliasPathTest < Minitest::Test

  def setup
    # Given
    @mock = AwsKmsKeyMock.new
    @mock_kms_key = @mock.disabled_kms

    # When
    @kms_key = AwsKmsKey.new(alias: "alias/#{@mock_kms_key[:key_id]}",
                             client_args: { stub_responses: true },
                             stub_data: @mock.stub_data_disabled)
  end

  def test_key_exists
    assert @kms_key.exists?
  end

  def test_key_enabled
    refute @kms_key.enabled?
  end


end