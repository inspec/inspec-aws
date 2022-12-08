require "aws_backend"

class AwsCloudFrontDistributions < AwsResourceBase
  name "aws_cloudfront_distributions"
  desc "Verifies settings for a collection AWS CloudFront Distributions."
  example '
    describe aws_cloudfront_distributions do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
    .register_column(:distribution_ids,                         field: :distribution_ids)
    .register_column(:distribution_arns,                        field: :distribution_arns)
    .register_column(:statuses,                                 field: :statuses)
    .register_column(:domain_names,                             field: :domain_names)
    .register_column(:origin_domain_names,                      field: :origin_domain_names)
    .register_column(:default_cache_viewer_protocol_policies,   field: :default_cache_viewer_protocol_policies)
    .register_column(:cache_viewer_protocol_policies,           field: :cache_viewer_protocol_policies)
    .register_column(:custom_origin_ssl_protocols,              field: :custom_origin_ssl_protocols)
    .register_column(:price_classes,                            field: :price_classes)
    .register_column(:enabled,                                  field: :enabled)
    .register_column(:viewer_certificate_ssl_support_methods,   field: :viewer_certificate_ssl_support_methods)
    .register_column(:viewer_certificate_minimum_ssl_protocols, field: :viewer_certificate_minimum_ssl_protocols)
    .register_column(:http_versions,                            field: :http_version)
    .register_column(:ipv6_enabled,                             field: :ipv6_enabled)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cfds = {}
    cfd_rows = []
    pagination_options = {}

    loop do
      catch_aws_errors do
        cfds = @aws.cloudfront_client.list_distributions(pagination_options).distribution_list
      end
      return cfd_rows if !cfds || cfds.items.empty?

      cfds.items.each do |cfd|
        custom_origin_ssl_protocols = []
        cfd.origins.items.each do |origin|
          if origin.custom_origin_config
            custom_origin_ssl_protocols += origin.custom_origin_config.origin_ssl_protocols.items
          end
        end
        custom_origin_ssl_protocols = custom_origin_ssl_protocols.uniq.sort

        cfd_rows += [{ distribution_ids:                         cfd.id,
                       distribution_arns:                        cfd.arn,
                       statuses:                                 cfd.status,
                       domain_names:                             cfd.domain_name,
                       origin_domain_names:                      cfd.origins.items.map(&:domain_name),
                       default_cache_viewer_protocol_policies:   cfd.default_cache_behavior.viewer_protocol_policy,
                       cache_viewer_protocol_policies:           cfd.cache_behaviors.items.map(&:viewer_protocol_policy),
                       custom_origin_ssl_protocols:              custom_origin_ssl_protocols,
                       price_classes:                            cfd.price_class,
                       enabled:                                  cfd.enabled,
                       viewer_certificate_ssl_support_method:    cfd.viewer_certificate.ssl_support_method,
                       viewer_certificate_minimum_ssl_protocols: cfd.viewer_certificate.minimum_protocol_version,
                       http_version:                             cfd.http_version,
                       ipv6_enabled:                             cfd.is_ipv6_enabled }]
      end
      break unless cfds.next_marker
      pagination_options = { marker: cfds.next_marker }
    end
    @table = cfd_rows
  end
end
