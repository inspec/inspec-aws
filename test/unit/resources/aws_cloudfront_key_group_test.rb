require 'helper'
require 'aws_cloudfront_key_group'
require 'aws-sdk-core'

class AwsCloudFrontKeyGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudFrontKeyGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsCloudFrontKeyGroup.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudFrontKeyGroup.new(unexpected: 9) }
  end
end

class AwsCloudFrontKeyGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_key_group
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:last_modified_time] = Time.parse('2022-09-08 01:56:24.000000000 +0000')
    mock_data[:key_group_config] = {
      name: 'test1',
      items: [],
      comment: 'test1'
    }
    data[:data] = { key_group: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AwsCloudFrontKeyGroup.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_key_group_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_last_modified_time
    assert_equal(@resp.last_modified_time, Time.parse('2022-09-08 01:56:24.000000000 +0000'))
  end

  def test_name
    assert_equal(@resp.key_group_config.name, 'test1')
  end

  def test_items
    assert_equal(@resp.key_group_config.items, [])
  end

  def test_comment
    assert_equal(@resp.key_group_config.comment, 'test1')
  end
end