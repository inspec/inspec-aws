require 'helper'
require 'aws_cloudfront_public_key'
require 'aws-sdk-core'

class AWSCloudFrontPublicKeyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontPublicKey.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontPublicKey.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFrontPublicKey.new(unexpected: 9) }
  end
end

class AWSCloudFrontPublicKeyHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_public_key
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:created_time] = Time.parse('2022-09-08 01:56:24.000000000 +0000')
    mock_data[:public_key_config] = {
      caller_reference: 'test1',
      name: 'test1',
      encoded_key: 'test1',
      comment: 'test1'
    }
    data[:data] = { public_key: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontPublicKey.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_public_key_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_created_time
    assert_equal(@resp.created_time, Time.parse('2022-09-08 01:56:24.000000000 +0000'))
  end

  def test_caller_reference
    assert_equal(@resp.public_key_config.caller_reference, 'test1')
  end

  def test_name
    assert_equal(@resp.public_key_config.name, 'test1')
  end

  def test_encoded_key
    assert_equal(@resp.public_key_config.encoded_key, 'test1')
  end

  def test_comment
    assert_equal(@resp.public_key_config.comment, 'test1')
  end
end