require 'helper'
require 'aws_cloud_front_origin_request_policy'
require 'aws-sdk-core'

class AWSCloudFrontOriginRequestPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontOriginRequestPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFrontOriginRequestPolicy.new(ids: 'rubbish') }
  end
end

class AWSCloudFrontOriginRequestPolicyHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_origin_request_policy
    mock_parameter = {}
    mock_parameter[:id] = "test1"
    mock_parameter[:last_modified_time] = Time.now
    mock_parameter[:origin_request_policy_config] = {comment: 'test1' , name: 'test1' , headers_config: {header_behavior: 'test1'}, cookies_config: {cookie_behavior: 'test1'}, query_strings_config: { query_string_behavior: 'test1'} }
    data[:data] = { origin_request_policy: mock_parameter }
    data[:client] = Aws::CloudFront::Client
    @origin_request_policy = AWSCloudFrontOriginRequestPolicy.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def origin_request_policy_exists
    assert @origin_request_policy.exists?
  end

  def test_origin_request_policy_id
    assert_equal(@origin_request_policy.id, 'test1')
  end

  def test_origin_request_policy_etag
    assert_equal(@origin_request_policy.origin_request_policy_config.name , 'test1')
  end
end