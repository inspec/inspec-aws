require 'helper'
require 'aws_cloudfront_public_keys'
require 'aws-sdk-core'

class AWSCloudFrontPublicKeysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudFrontPublicKeys.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFrontPublicKeys.new('rubbish') }
  end

  def test_cloudfront_public_keys_non_existing_for_empty_response
    refute AWSCloudFrontPublicKeys.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFrontPublicKeysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_public_keys
    mock_data = {}
    mock_data[:max_items] = 1
    mock_data[:quantity] = 1
    mock_data[:items] = [
      id: 'test1',
      created_time: Time.parse('2022-09-08 01:56:24.000000000 +0000'),
      name: 'test1',
      encoded_key: 'test1',
      comment: 'test1',

    ]
    data[:data] = { public_key_list: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontPublicKeys.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_public_key_exists
    assert @resp.exists?
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_created_time
    assert_equal(@resp.created_time, [ Time.parse('2022-09-08 01:56:24.000000000 +0000') ])
  end

  def test_caller_references
    assert_equal(@resp.names, ['test1'])
  end

  def test_names
    assert_equal(@resp.comments, ['test1'])
  end

  def test_encoded_keys
    assert_equal(@resp.encoded_keys, ['test1'])
  end

  def test_comments
    assert_equal(@resp.comments, ['test1'])
  end
end