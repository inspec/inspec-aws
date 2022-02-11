require 'helper'
require 'aws_ssm_resource_data_syncs'
require 'aws-sdk-core'

class AWSSESResourceDataSyncsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESResourceDataSyncs.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESResourceDataSyncs.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESResourceDataSyncs.new(unexpected: 9) }
  end
end

class AWSSESResourceDataSyncsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_resource_data_sync
    mock_data = {}
    mock_data[:sync_name] = 'test1'
    mock_data[:sync_type] = 'test1'
    mock_data[:last_sync_time] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:last_successful_sync_time] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:sync_last_modified_time] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:last_status] = 'test1'
    mock_data[:sync_created_time] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:last_sync_status_message] = 'test1'
    data[:data] = { resource_data_sync_items: [mock_data] }
    data[:client] = Aws::SSM::Client
    @resp = AWSSESResourceDataSyncs.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_data_sync_items_exists
    assert @resp.exists?
  end

  def test_sync_names
    assert_equal(@resp.sync_names, ['test1'])
  end

  def test_sync_types
    assert_equal(@resp.sync_types, ['test1'])
  end

  def test_last_sync_times
    assert_equal(@resp.last_sync_times, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_last_successful_sync_times
    assert_equal(@resp.last_successful_sync_times, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_sync_last_modified_times
    assert_equal(@resp.sync_last_modified_times, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_last_statuses
    assert_equal(@resp.last_statuses, ['test1'])
  end

  def test_sync_created_times
    assert_equal(@resp.sync_created_times, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_last_sync_status_messages
    assert_equal(@resp.last_sync_status_messages, ['test1'])
  end
end