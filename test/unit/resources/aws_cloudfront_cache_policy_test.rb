require 'helper'
require 'aws_cloudfront_cache_policy'
require 'aws-sdk-core'

class AWSCloudFrontCachePolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontCachePolicy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontCachePolicy.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFrontCachePolicy.new(unexpected: 9) }
  end
end

class AWSCloudFrontCachePolicySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_cache_policy
    mock_data = {}
    mock_data[:cache_policy] = {
      id: 'test1',
      last_modified_time: Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
      cache_policy_config: {
        comment: 'test1',
        name: 'test1',
        default_ttl: 1,
        max_ttl: 1,
        min_ttl: 1,
        parameters_in_cache_key_and_forwarded_to_origin: {
          enable_accept_encoding_gzip: true,
          enable_accept_encoding_brotli: true,
          headers_config: {
            header_behavior: 'test1'
          },
          cookies_config: {
            cookie_behavior: 'test1'
          },
          query_strings_config: {
            query_string_behavior: 'test1'
          }
        }
      }
    }
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontCachePolicy.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_cache_policy_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_last_modified_time
    assert_equal(@resp.last_modified_time, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_comment
    assert_equal(@resp.cache_policy_config.comment, 'test1')
  end

  def test_name
    assert_equal(@resp.cache_policy_config.name, 'test1')
  end

  def test_default_ttl
    assert_equal(@resp.cache_policy_config.default_ttl, 1)
  end

  def test_max_ttl
    assert_equal(@resp.cache_policy_config.max_ttl, 1)
  end

  def test_min_ttl
    assert_equal(@resp.cache_policy_config.min_ttl, 1)
  end

  def test_enable_accept_encoding_gzip
    assert_equal(@resp.cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_gzip, true)
  end

  def test_enable_accept_encoding_brotli
    assert_equal(@resp.cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_brotli, true)
  end

  def test_header_behavior
    assert_equal(@resp.cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.header_behavior, 'test1')
  end

  def test_header_behavior
    assert_equal(@resp.cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookie_behavior, 'test1')
  end

  def test_query_string_behavior
    assert_equal(@resp.cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_string_behavior, 'test1')
  end
end
