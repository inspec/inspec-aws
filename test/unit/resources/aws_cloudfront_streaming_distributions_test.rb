require 'helper'
require 'aws_cloudfront_streaming_distributions'
require 'aws-sdk-core'

class AWSCloudFrontStreamingDistributionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudFrontStreamingDistributions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFrontStreamingDistributions.new('rubbish') }
  end

  def test_streaming_distribution_list_non_existing_for_empty_response
    refute AWSCloudFrontStreamingDistributions.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFrontStreamingDistributionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_streaming_distributions
    mock_data = {}
    mock_data[:marker] = 'test1'
    mock_data[:quantity] = 1
    mock_data[:max_items] = 1
    mock_data[:is_truncated] = false
    mock_data[:items] = []
    data[:data] = {:streaming_distribution_list => mock_data}
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontStreamingDistributions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_streaming_distribution_list_exists
    assert @resp.exists?
  end
end