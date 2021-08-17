require 'helper'
require 'aws-sdk-core'
require 'aws_cloudfront_distribution'
require_relative 'mock/aws_cloudfront_distribution_mock'

class AwsCloudFrontDistributionConstructionTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudFrontDistribution.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_distribution_id
    AwsCloudFrontDistribution.new(distribution_id: 'id', client_args: { stub_responses: true })
  end

  def test_accepts_distribution_id_and_disallowed_ssl_protocols_string
    AwsCloudFrontDistribution.new(distribution_id: 'id', disallowed_ssl_protocols: 'SSLv3',
                                  client_args: { stub_responses: true })
  end

  def test_accepts_distribution_id_and_disallowed_ssl_protocols_array
    AwsCloudFrontDistribution.new(distribution_id: 'id',
                                  disallowed_ssl_protocols: %w{SSLv3 TLSv1 TLSv1_2016 TLSv1.1 TLSv1.1_2016},
                                  client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudFrontDistribution.new(rubbish: 'rubbish') }
  end

  def test_cloudfront_disribution_non_existing
    refute AwsCloudFrontDistribution.new(distribution_id: 'id-not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudFrontDistributionS3OriginDefaultCertificateTest < Minitest::Test
  def setup
    stub_data = AwsCloudFrontDistributionMock.new.stub_default_data
    @mock_cfd = stub_data.first[:data][:distribution]

    @cloudfront_distribution = AwsCloudFrontDistribution.new(
      distribution_id: @mock_cfd[:id],
      client_args: { stub_responses: true },
      stub_data: stub_data
    )
  end

  def test_distribution_id
    assert_equal(@cloudfront_distribution.distribution_id, @mock_cfd[:id])
  end

  def test_viewer_certificate_minimum_ssl_protocol
    assert_equal(@cloudfront_distribution.viewer_certificate_minimum_ssl_protocol,
                 @mock_cfd[:distribution_config][:viewer_certificate][:minimum_protocol_version])
  end

  def test_viewer_protocol_policies
    assert_equal(@cloudfront_distribution.viewer_protocol_policies,
                 [@mock_cfd[:distribution_config][:default_cache_behavior][:viewer_protocol_policy]])
  end

  def test_custom_ssl_protocols
    assert_equal(@cloudfront_distribution.custom_origin_ssl_protocols, [])
  end

  def test_s3_origin_configs
    assert_equal(@cloudfront_distribution.s3_origin_configs, true)
  end

  def test_has_viewer_protocol_policies_allowing_http
    assert @cloudfront_distribution.has_viewer_protocol_policies_allowing_http?
  end

  def test_has_disallowed_viewer_minimum_ssl_protocol
    assert @cloudfront_distribution.has_disallowed_viewer__minimum_ssl_protocol?
  end

  def test_has_s3_origin_configs
    assert @cloudfront_distribution.has_s3_origin_configs?
  end

  def test_has_disallowed_custom_origin_ssl_protocols
    refute @cloudfront_distribution.has_disallowed_custom_origin_ssl_protocols?
  end

  def test_disallowed
    assert @cloudfront_distribution.send(:disallowed?, %w{SSLv3})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1_2016})
    assert @cloudfront_distribution.send(:disallowed?, %w{SSLv3 TLSv1.2})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSV1.2_2018 TLSv1})

    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.1})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.1_2016})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2018})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2019})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2021})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSV1.2_2018 TLSv1.1 TLSv1.2_2021})
  end
end

class AwsCloudFrontDistributionCustomTest < Minitest::Test
  def setup
    stub_data = AwsCloudFrontDistributionMock.new.stub_custom_data
    @mock_cfd = stub_data.first[:data][:distribution]

    @cloudfront_distribution = AwsCloudFrontDistribution.new(
      distribution_id: @mock_cfd[:id],
      disallowed_ssl_protocols: %w{SSLv3 TLSv1 TLSv1_2016 TLSv1.1 TLSv1.1_2016},
      client_args: { stub_responses: true },
      stub_data: stub_data
    )
  end

  def test_viewer_certificate_minimum_ssl_protocol
    assert_equal(@cloudfront_distribution.viewer_certificate_minimum_ssl_protocol,
                 @mock_cfd[:distribution_config][:viewer_certificate][:minimum_protocol_version])
  end

  def test_viewer_protocol_policies
    assert_equal(@cloudfront_distribution.viewer_protocol_policies,
                 ["https-only", "redirect-to-https"])
  end

  def test_custom_ssl_protocols
    assert_equal(@cloudfront_distribution.custom_origin_ssl_protocols,
                 ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"])
  end

  def test_s3_origin_configs
    refute @cloudfront_distribution.s3_origin_configs
  end

  def test_has_viewer_protocol_policies_allowing_http
    refute @cloudfront_distribution.has_viewer_protocol_policies_allowing_http?
  end

  def test_has_disallowed_viewer_minimum_ssl_protocol
    assert @cloudfront_distribution.has_disallowed_viewer_minimum_ssl_protocol?
  end

  def test_has_s3_origin_configs
    refute @cloudfront_distribution.has_s3_origin_configs?
  end

  def test_has_disallowed_custom_origin_ssl_protocols
    assert @cloudfront_distribution.has_disallowed_custom_origin_ssl_protocols?
  end

  def test_disallowed
    assert @cloudfront_distribution.send(:disallowed?, %w{SSLv3})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1_2016})
    assert @cloudfront_distribution.send(:disallowed?, %w{SSLv3 TLSv1.2})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSV1.2_2018 TLSv1})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1.1})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSv1.1_2016})
    assert @cloudfront_distribution.send(:disallowed?, %w{TLSV1.2_2018 TLSv1.1 TLSv1.2_2021})

    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2018})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2019})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2021})
    refute @cloudfront_distribution.send(:disallowed?, %w{TLSv1.2_2021 TLSv1.2_2019 TLSv1.2_2018 TLSv1.2})
  end
end
