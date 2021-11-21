require 'helper'
require 'aws_cloudfront_key_groups'
require 'aws-sdk-core'

class AwsCloudFrontKeyGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsCloudFrontKeyGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsCloudFrontKeyGroups.new('rubbish') }
  end

  def test_key_groups_non_existing_for_empty_response
    refute AwsCloudFrontKeyGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsCloudFrontKeyGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_key_groups
    mock_data = {}
    mock_data[:max_items] = 1
    mock_data[:quantity] = 1
    mock_data[:items] = [
      key_group: {
        id: 'test1',
        last_modified_time: Time.parse('2022-09-08 01:56:24.000000000 +0000'),
        key_group_config: {
          name: 'test1',
          items: [],
          comment: 'test1'
        }
      }
    ]
    data[:data] = { :key_group_list => mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AwsCloudFrontKeyGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_key_group_exists
    assert @resp.exists?
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_last_modified_times
    assert_equal(@resp.last_modified_time, [Time.parse('2022-09-08 01:56:24.000000000 +0000')])
  end

  def test_names
    assert_equal(@resp.key_group_config_names, ['test1'])
  end

  def test_items
    assert_equal(@resp.key_group_config_items, [])
  end

  def test_comments
    assert_equal(@resp.key_group_config_comments, ['test1'])
  end
end