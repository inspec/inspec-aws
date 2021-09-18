require 'helper'
require 'aws_cloudfront_cache_policies'
require 'aws-sdk-core'

class AWSCloudFrontCachePoliciesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudFrontCachePolicies.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFrontCachePolicies.new('rubbish') }
  end

  def test_cache_policy_non_existing_for_empty_response
    refute AWSCloudFrontCachePolicies.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFrontCachePoliciesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_cache_policies
    mock_data = {}
    mock_data[:cache_policy_list] = {
      max_items: 1,
      quantity: 1,
      items: [
        type: 'test1',
        cache_policy: {
          id: 'test1',
          last_modified_time: Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"),
          cache_policy_config: {
            comment: 'test1',
            name: 'test1',
            default_ttl: 1,
            max_ttl: 1,
            min_ttl: 1
          }
        }
      ]
    }
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontCachePolicies.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_types
    assert_equal(@resp.types, ['test1'])
  end
end
