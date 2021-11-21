require 'helper'
require 'aws_cloudfront_origin_access_identity'
require 'aws-sdk-core'

class AWSCloudFrontOriginAccessIdentityConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontOriginAccessIdentity.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontOriginAccessIdentity.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFrontOriginAccessIdentity.new(unexpected: 9) }
  end
end

class AWSCloudFrontOriginAccessIdentitySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_cloud_front_origin_access_identity
    mock_data = {}
    mock_data[:cloud_front_origin_access_identity] = {
      id: 'test1',
      s3_canonical_user_id: 'test1',
      cloud_front_origin_access_identity_config: {
        caller_reference: 'test1',
        comment: 'test1'
      }
    }
    data[:data] = [mock_data]
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontOriginAccessIdentity.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_origin_access_identity_config_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_s3_canonical_user_id
    assert_equal(@resp.s3_canonical_user_id, 'test1')
  end

  def test_caller_reference
    assert_equal(@resp.cloud_front_origin_access_identity_config.caller_reference, 'test1')
  end

  def test_comment
    assert_equal(@resp.cloud_front_origin_access_identity_config.comment, 'test1')
  end
end
