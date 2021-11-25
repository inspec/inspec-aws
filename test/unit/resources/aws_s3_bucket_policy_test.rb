require 'helper'
require 'aws_s3_bucket_policy'
require 'aws-sdk-core'

class AWSS3BucketPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSS3BucketPolicy.new(bucket: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSS3BucketPolicy.new(bucket: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSS3BucketPolicy.new(unexpected: 9) }
  end
end

class AWSS3BucketPolicySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_bucket_policy
    mock_data = {}
    mock_data[:policy] = '{"Version"=>"2012-10-17", "Id"=>"Policy1637840900212", "Statement"=>[{"Sid"=>"Stmt1637840894970", "Effect"=>"Allow", "Principal"=>{"AWS"=>"*"}, "Action"=>"s3:*", "Resource"=>"arn:aws:s3:::test-112334"}]}'
    data[:data] = mock_data
    data[:client] = Aws::S3::Client
    @resp = AWSS3BucketPolicy.new(bucket: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_s3_policy_exist
    assert @resp.exists?
  end

  def test_Version
    assert_equal(@resp.Version, "2012-10-17")
  end
end