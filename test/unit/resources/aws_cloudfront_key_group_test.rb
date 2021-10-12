require 'helper'
require 'aws_cloudfront_key_group'
require 'aws-sdk-core'

class AwsCloudfrontKeyGroupConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsCloudfrontKeyGroup.new(id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsCloudfrontKeyGroup.new('rubbish') }
  end

  def test_key_group_non_existing_for_empty_response
    refute AwsCloudfrontKeyGroup.new(id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AwsCloudfrontKeyGroupHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_key_group
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:last_modified_time] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:key_group_config] = {
      name: "test1",
      items: [],
      comment: "test1"
    }
    data[:data] = { key_group: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AwsCloudfrontKeyGroup.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_key_group_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@res.id, 'test1')
  end

  def test_last_modified_time
    assert_equal(@res.last_modified_time, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_name
    assert_equal(@res.key_group_config.name, 'test1')
  end

  def test_items
    assert_equal(@res.key_group_config.items, [])
  end

  def test_comment
    assert_equal(@res.key_group_config.comment, 'test1')
  end
end