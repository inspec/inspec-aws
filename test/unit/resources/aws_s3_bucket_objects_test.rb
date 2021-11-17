require 'helper'
require 'aws_s3_bucket_objects'
require 'aws-sdk-core'

class AwsS3BucketObjectsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsS3BucketObjects.new(bucket_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsS3BucketObjects.new('rubbish') }
  end
end

class AwsS3BucketObjectsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_objects_v2
    mock_data = {}
    mock_data[:is_truncated] = true
    mock_data[:name] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::S3::Client
    @resp = AwsS3BucketObjects.new(bucket_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end
end