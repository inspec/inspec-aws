require 'helper'
require 'aws_s3_buckets'
require 'aws-sdk-core'

class AwsS3BucketsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsS3Buckets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsS3Buckets.new('rubbish') }
  end

  def test_buckets_non_existing_for_empty_response
    refute AwsS3Buckets.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsS3BucketsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_buckets
    data[:data] = { :buckets => [{ :name => 'test' }] }
    data[:client] = Aws::S3::Client
    @buckets = AwsS3Buckets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_buckets_exists
    assert @buckets.exist?
  end

  def test_buckets_ids
    assert_equal(@buckets.bucket_names, ['test'])
  end

  def test_buckets_filtering_not_there
    refute @buckets.where(:bucket_name => 'bad').exist?
  end

  def test_buckets_filtering_there
    assert @buckets.where(:bucket_name => 'test').exist?
  end
end