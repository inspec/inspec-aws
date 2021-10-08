require 'helper'
require 'aws_cloudfront_streaming_distribution'
require 'aws-sdk-core'

class AWSCloudFrontStreamingDistributionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontStreamingDistribution.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFrontStreamingDistribution.new(id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFrontStreamingDistribution.new(unexpected: 9) }
  end
end

class AWSCloudFrontStreamingDistributionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_streaming_distribution
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:last_modified_time] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:domain_name] = 'test1'
    mock_data[:active_trusted_signers] = {
      enabled: true,
      quantity: 1,
      items: []
    }
    mock_data[:streaming_distribution_config] = {
      caller_reference: 'test1',
      s3_origin: {
        domain_name: 'test1',
        origin_access_identity: 'test1'
      },
      aliases: {
        quantity: 1,
        items: []
      },
      comment: 'test1',
      logging: {
        enabled: true,
        bucket: 'test1',
        prefix: 'test1'
      },
      trusted_signers: {
        enabled: true,
        quantity: 1,
        items: []
      },
      price_class: 'test1',
      enabled: true
    }
    data[:data] = { streaming_distribution: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AWSCloudFrontStreamingDistribution.new(id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_streaming_distribution_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_arn
    assert_equal(@resp.arn, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_last_modified_time
    assert_equal(@resp.last_modified_time, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_active_trusted_signers_enabled
    assert_equal(@resp.active_trusted_signers.enabled, true)
  end

  def test_active_trusted_signers_quantity
    assert_equal(@resp.active_trusted_signers.quantity, 1)
  end

  def test_active_trusted_signers_items
    assert_equal(@resp.active_trusted_signers.items, [])
  end

  def test_streaming_distribution_config_caller_reference
    assert_equal(@resp.streaming_distribution_config.caller_reference, 'test1')
  end

  def test_streaming_distribution_config_caller_reference_s3_origin_domain_name
    assert_equal(@resp.streaming_distribution_config.s3_origin.domain_name, 'test1')
  end

  def test_streaming_distribution_config_caller_reference_s3_origin_origin_access_identity
    assert_equal(@resp.streaming_distribution_config.s3_origin.origin_access_identity, 'test1')
  end

  def test_streaming_distribution_config_aliases_quantity
    assert_equal(@resp.streaming_distribution_config.aliases.quantity, 1)
  end

  def test_streaming_distribution_config_aliases_items
    assert_equal(@resp.streaming_distribution_config.aliases.items, [])
  end

  def test_streaming_distribution_config_comment
    assert_equal(@resp.streaming_distribution_config.comment, 'test1')
  end

  def test_streaming_distribution_config_logging_enabled
    assert_equal(@resp.streaming_distribution_config.logging.enabled, true)
  end

  def test_streaming_distribution_config_logging_bucket
    assert_equal(@resp.streaming_distribution_config.logging.bucket, 'test1')
  end

  def test_streaming_distribution_config_logging_prefix
    assert_equal(@resp.streaming_distribution_config.logging.prefix, 'test1')
  end

  def test_streaming_distribution_config_trusted_signers_enabled
    assert_equal(@resp.streaming_distribution_config.trusted_signers.enabled, true)
  end

  def test_streaming_distribution_config_trusted_signers_quantity
    assert_equal(@resp.streaming_distribution_config.trusted_signers.quantity, 1)
  end

  def test_streaming_distribution_config_trusted_signers_items
    assert_equal(@resp.streaming_distribution_config.trusted_signers.items, [])
  end

  def test_streaming_distribution_config_price_class
    assert_equal(@resp.streaming_distribution_config.price_class, 'test1')
  end

  def test_streaming_distribution_config_enabled
    assert_equal(@resp.streaming_distribution_config.enabled, true)
  end
end