require_relative 'aws_base_resource_mock'

class AwsCloudFrontDistributionMock < AwsBaseResourceMock

  def initialize
    super
    @cfd_default_config = {
      enabled: true,
      comment: 'a comment',
      http_version: 'http2',
      origins: {
        quantity: 1,
        items: [{
          id: 'id1',
          domain_name: 'something.s3.amazonaws.com',
          s3_origin_config: {
            origin_access_identity: "origin-access-identity/cloudfront/XYZABC",
          }
        }]
      },
      default_cache_behavior: {
        target_origin_id: 'id1',
        viewer_protocol_policy: 'allow-all'
      },
      cache_behaviors: {
        quantity: 0,
        items: []
      },
      viewer_certificate: {
        cloud_front_default_certificate: true,
        minimum_protocol_version: 'TLSv1',
        certificate_source: 'cloudfront'
      }
    }

    @cfd_default_top = {
      id: 'CLOUD99',
      arn: 'aws:cloudfront::123456789012:distribution/CLOUD99',
      status: 'InProgress',
      last_modified_time: Time.now,
      domain_name: 'something1.cloudfront.net'
    }

    @cfd_default = @cfd_default_top.dup
    @cfd_default[:in_progress_invalidation_batches] = 0
    @cfd_default[:distribution_config] = @cfd_default_config.dup
    @cfd_default[:distribution_config][:caller_reference] = ''

    @cfd_custom_config = {
      enabled: true,
      comment: 'a comment',
      http_version: 'http2',
      origins: {
        quantity: 3,
        items: [{
          id: 'origin1',
          domain_name: 'origin1.com',
          custom_origin_config: {
            http_port: 80,
            https_port: 443,
            origin_protocol_policy: 'https-only',
            origin_ssl_protocols: {
              quantity: 2,
              items: ['TLSv1.1', 'TLSv1.2']
            }
          }
        }, {
          id: 'origin2',
          domain_name: 'origin2.com',
          custom_origin_config: {
            http_port: 80,
            https_port: 443,
            origin_protocol_policy: 'redirect-to-https',
            origin_ssl_protocols: {
              quantity: 3,
              items: ['TLSv1', 'TLSv1.1', 'TLSv1.2']
            }
          }
        }, {
          id: 'origin3',
          domain_name: 'origin3.com',
          custom_origin_config: {
            http_port: 80,
            https_port: 443,
            origin_protocol_policy: 'https-only',
            origin_ssl_protocols: {
              quantity: 4,
              items: ['SSLv3', 'TLSv1', 'TLSv1.1', 'TLSv1.2']
            }
          }
        }]
      },
      default_cache_behavior: {
        target_origin_id: 'origin1',
        viewer_protocol_policy: 'redirect-to-https'
      },
      cache_behaviors: {
        quantity: 2,
        items: [{
          path_pattern: '/content/2/*',
          target_origin_id: 'origin2',
          viewer_protocol_policy: 'https-only'
        }, {
          path_pattern: '/content/3/*',
          target_origin_id: 'origin3',
          viewer_protocol_policy: 'redirect-to-https'
        }]
      },
      viewer_certificate: {
        cloud_front_default_certificate: true,
        minimum_protocol_version: 'TLSv1.1_2016',
        certificate_source: 'cloudfront'
      }
    }

    @cfd_custom_top = {
      id: 'CLOUD100',
      arn: 'aws:cloudfront::123456789012:distribution/CLOUD100',
      status: 'Deployed',
      last_modified_time: Time.now,
      domain_name: 'something2.cloudfront.net'
    }

    @cfd_custom = @cfd_custom_top.dup
    @cfd_custom[:in_progress_invalidation_batches] = 0
    @cfd_custom[:distribution_config] = @cfd_custom_config.dup
    @cfd_custom[:distribution_config][:caller_reference] = ''
  end

  def stub_default_data
    [{
      client: Aws::CloudFront::Client,
      method: :get_distribution,
      data: { distribution: @cfd_default }
    }]
  end

  def stub_custom_data
    [{
      client: Aws::CloudFront::Client,
      method: :get_distribution,
      data: { distribution: @cfd_custom }
    }]
  end

  def stub_collection
    additional_required_data = {
      aliases: {
        quantity: 0,
        items: []
      },
      custom_error_responses: {
        quantity: 0,
        items: []
      },
      price_class: '',
      restrictions: {
        geo_restriction: {
          restriction_type: '',
          quantity: 0
        },
      },
      web_acl_id: '',
      is_ipv6_enabled: false
    }

    @cfd_item_1 = @cfd_default_config.merge(@cfd_default_top).merge(additional_required_data)
    @cfd_item_2 = @cfd_custom_config.merge(@cfd_custom_top).merge(additional_required_data)

    [{
      client: Aws::CloudFront::Client,
      method: :list_distributions,
      data: {
        distribution_list: {
          marker: '',
          max_items: 100,
          is_truncated: false,
          quantity: 2,
          items: [@cfd_item_1, @cfd_item_2]
        }
      }
    }]
  end
end
