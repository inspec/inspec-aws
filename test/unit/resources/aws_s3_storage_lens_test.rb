require 'helper'
require 'aws_s3_storage_lens'
require 'aws-sdk-core'

class AWSS3StorageLensConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSS3StorageLens.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSS3StorageLens.new(config_id: '', account_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSS3StorageLens.new(unexpected: 9) }
  end
end

class AWSS3StorageLensSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_storage_lens_configuration
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:account_level] = {
      bucket_level: {}
    }
    mock_data[:is_enabled] = true
    mock_data[:storage_lens_arn] = 'test1'
    data[:data] = { storage_lens_configuration: mock_data }
    data[:client] = Aws::S3Control::Client
    @resp = AWSS3StorageLens.new(config_id: 'test1', account_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_storage_lens_configuration_exist
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_is_enabled
    assert_equal(@resp.is_enabled, true)
  end

  def test_storage_lens_arn
    assert_equal(@resp.storage_lens_arn, 'test1')
  end
end
