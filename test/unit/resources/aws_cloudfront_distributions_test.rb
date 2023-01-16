require 'helper'
require 'aws-sdk-core'
require 'aws_cloudfront_distributions'
require_relative 'mock/aws_cloudfront_distribution_mock'

class AwsCloudFrontDistributionsConstructionTest < Minitest::Test
  def test_empty_params_ok
    AwsCloudFrontDistributions.new(client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudFrontDistributions.new(rubbish: 'rubbish') }
  end

  def test_cloudfront_disributions_non_existing_for_empty_response
    refute AwsCloudFrontDistributions.new(client_args: { stub_responses: true }).exist?
  end
end
