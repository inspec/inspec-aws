require 'helper'
require 'aws_s3_storage_lenses'
require 'aws-sdk-core'

class AWSS3StorageLensesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSS3StorageLenses.new(account_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSS3StorageLenses.new('rubbish') }
  end

  def test_storage_lens_configuration_list_non_existing_for_empty_response
    refute AWSS3StorageLenses.new(account_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSS3StorageLensesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_storage_lens_configurations
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:storage_lens_arn] = 'test1'
    mock_data[:home_region] = 'test1'
    mock_data[:is_enabled] = true
    data[:data] = { storage_lens_configuration_list: [mock_data] }
    data[:client] = Aws::S3Control::Client
    @resp = AWSS3StorageLenses.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_storage_lens_configuration_list_exists
    assert @resp.exists?
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_storage_lens_arns
    assert_equal(@resp.storage_lens_arns, ['test1'])
  end

  def test_home_regions
    assert_equal(@resp.home_regions, ['test1'])
  end

  def test_is_enabled
    assert_equal(@resp.is_enabled, [true])
  end
end