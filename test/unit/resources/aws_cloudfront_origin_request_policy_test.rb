require 'helper'
require 'aws_cloudfront_origin_request_policy'
require 'aws-sdk-core'

class AWSCloudFrontOriginRequestPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontOriginRequestPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontOriginRequestPolicy.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFrontOriginRequestPolicy.new(unexpected: 9) }
  end
end

class AWSCloudFrontOriginRequestPolicyHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_origin_request_policy
    mock_parameter = {}
    mock_parameter[:id] = "test1"
    mock_parameter[:last_modified_time] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_parameter[:origin_request_policy_config] = { comment: 'test1',
                                                      name: 'test1',
                                                      headers_config: {
                                                        header_behavior: 'test1',
                                                        headers: {
                                                          quantity: 1
                                                        }
                                                      },
                                                      cookies_config: {
                                                        cookie_behavior: 'test1'
                                                      },
                                                      query_strings_config: {
                                                        query_string_behavior: 'test1'
                                                      } }
    data[:data] = { origin_request_policy: mock_parameter }
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontOriginRequestPolicy.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def origin_request_policy_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_last_modified_time
    assert_equal(@resp.last_modified_time, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_origin_request_policy_config_comment
    assert_equal(@resp.origin_request_policy_config.name , 'test1')
  end

  def test_origin_request_policy_config_comment
    assert_equal(@resp.origin_request_policy_config.comment , 'test1')
  end

  def test_origin_request_policy_config_headers_config_header_behavior
    assert_equal(@resp.origin_request_policy_config.headers_config.header_behavior , 'test1')
  end

  def test_origin_request_policy_config_headers_config_headers_quantity
    assert_equal(@resp.origin_request_policy_config.headers_config.headers.quantity , 1)
  end

  def test_origin_request_policy_config_cookies_config_cookie_behavior
    assert_equal(@resp.origin_request_policy_config.cookies_config.cookie_behavior , 'test1')
  end

  def test_origin_request_policy_config_query_strings_config_query_string_behavior
    assert_equal(@resp.origin_request_policy_config.query_strings_config.query_string_behavior , 'test1')
  end
end
