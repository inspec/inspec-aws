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

class AwsCloudFrontDistributionsTest < Minitest::Test
  # def setup
  #   @mock_cfds = AwsCloudFrontDistributionMock.new.stub_collection
  #   @mock_cfd_1 = @mock_cfds.first[:data][:distribution_list][:items][0]
  #   @mock_cfd_2 = @mock_cfds.first[:data][:distribution_list][:items][1]
  #
  #   @cfds = AwsCloudFrontDistributions.new(
  #     client_args: { stub_responses: true },
  #     stub_data: @mock_cfds
  #   )
  # end
  #
  # def test_distribution_ids
  #   assert_equal(@cfds.distribution_ids, [@mock_cfd_1[:id], @mock_cfd_2[:id]])
  # end
  #
  # def test_distribution_arns
  #   assert_equal(@cfds.distribution_arns, [@mock_cfd_1[:arn], @mock_cfd_2[:arn]])
  # end
  #
  # def test_statuses
  #   assert_equal(@cfds.statuses, [@mock_cfd_1[:status], @mock_cfd_2[:status]])
  # end
  #
  # def test_domain_names
  #   assert_equal(@cfds.domain_names, [@mock_cfd_1[:domain_name], @mock_cfd_2[:domain_name]])
  # end
  #
  # def test_origin_domain_names
  #   assert_equal(@cfds.origin_domain_names, [[@mock_cfd_1[:origins][:items][0][:domain_name]],
  #                                            [@mock_cfd_2[:origins][:items][0][:domain_name],
  #                                             @mock_cfd_2[:origins][:items][1][:domain_name],
  #                                             @mock_cfd_2[:origins][:items][2][:domain_name]]])
  # end
  #
  # def test_default_cache_viewer_protocol_policies
  #   assert_equal(@cfds.default_cache_viewer_protocol_policies,
  #               [@mock_cfd_1[:default_cache_behavior][:viewer_protocol_policy],
  #                @mock_cfd_2[:default_cache_behavior][:viewer_protocol_policy]])
  # end
  #
  # def test_cache_viewer_protocol_policies
  #   assert_equal(@cfds.cache_viewer_protocol_policies, [[], [@mock_cfd_2[:cache_behaviors][:items][0][:viewer_protocol_policy],
  #                                                            @mock_cfd_2[:cache_behaviors][:items][1][:viewer_protocol_policy]]])
  # end
  #
  # def test_custom_origin_ssl_protocols
  #   assert_equal(@cfds.custom_origin_ssl_protocols, [[], ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]])
  # end
  #
  # def test_price_classes
  #   assert_equal(@cfds.price_classes, [@mock_cfd_1[:price_class], @mock_cfd_2[:price_class]])
  # end
  #
  # def test_enabled
  #   assert_equal(@cfds.enabled, [@mock_cfd_1[:enabled], @mock_cfd_2[:enabled]])
  # end
  #
  # def test_viewer_certificate_ssl_support_methods
  #   assert_equal(@cfds.viewer_certificate_ssl_support_methods,
  #               [@mock_cfd_1[:viewer_certificate][:ssl_support_methods],
  #                @mock_cfd_2[:viewer_certificate][:ssl_support_methods]])
  # end
  #
  # def test_viewer_certificate_minimum_ssl_protocols
  #   assert_equal(@cfds.viewer_certificate_minimum_ssl_protocols,
  #               [@mock_cfd_1[:viewer_certificate][:minimum_protocol_version],
  #                @mock_cfd_2[:viewer_certificate][:minimum_protocol_version]])
  # end
  #
  # def test_http_version
  #   assert_equal(@cfds.http_versions, [@mock_cfd_1[:http_version], @mock_cfd_2[:http_version]])
  # end
  #
  # def test_ipv6_enabled
  #   assert_equal(@cfds.ipv6_enabled, [@mock_cfd_1[:is_ipv6_enabled], @mock_cfd_2[:is_ipv6_enabled]])
  # end
end
