require 'helper'
require 'aws_cloudfront_origin_access_identities'
require 'aws-sdk-core'

class AWSCloudFrontOriginAccessIdentitiesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudFrontOriginAccessIdentities.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFrontOriginAccessIdentities.new('rubbish') }
  end

  def test_cache_policy_non_existing_for_empty_response
    refute AWSCloudFrontOriginAccessIdentities.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFrontOriginAccessIdentitiesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_cloud_front_origin_access_identities
    mock_data = {}
    mock_data[:cloud_front_origin_access_identity_list] = {
      marker: "test1",
      is_truncated: true,
      max_items: 1,
      quantity: 1,
      items: [
        {
          id: 'test1',
          s3_canonical_user_id: 'test1',
          comment: 'test1'
        }
      ]
    }
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontOriginAccessIdentities.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_cache_policy_exists
    assert @resp.exists?
  end
end
