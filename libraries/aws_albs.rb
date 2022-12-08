require "aws_backend"

class AwsAlbs < AwsResourceBase
  name "aws_albs"
  desc "Verifies settings for a collection AWS Application Load Balancers."
  example "
    describe aws_albs do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:availability_zones,        field: :availability_zones)
    .register_column(:canonical_hosted_zone_ids, field: :canonical_hosted_zone_id)
    .register_column(:dns_names,                 field: :dns_name)
    .register_column(:load_balancer_arns,        field: :load_balancer_arn)
    .register_column(:load_balancer_names,       field: :load_balancer_name)
    .register_column(:load_balancer_addresses,   field: :load_balancer_addresses)
    .register_column(:schemes,                   field: :scheme)
    .register_column(:security_groups,           field: :security_groups)
    .register_column(:states,                    field: :state)
    .register_column(:subnets,                   field: :subnets)
    .register_column(:types,                     field: :type)
    .register_column(:vpc_ids,                   field: :vpc_id)
    .register_column(:zone_names,                field: :zone_names)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    alb_rows = []
    load_balancers = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        load_balancers = @aws.elb_client_v2.describe_load_balancers(pagination_options)
      end
      return [] if !load_balancers || load_balancers.empty?

      load_balancers.load_balancers.each do |l|
        alb_rows += [{ availability_zones:       l.availability_zones,
                       zone_names:               l.availability_zones.map(&:zone_name),
                       subnets:                  l.availability_zones.map(&:subnet_id),
                       load_balancer_addresses:  l.availability_zones.map(&:load_balancer_addresses).flatten,
                       canonical_hosted_zone_id: l.canonical_hosted_zone_id,
                       created_time:             l.created_time.to_s,
                       dns_name:                 l.dns_name,
                       load_balancer_arn:        l.load_balancer_arn,
                       load_balancer_name:       l.load_balancer_name,
                       security_groups:          l.security_groups,
                       scheme:                   l.scheme,
                       state:                    l.state,
                       type:                     l.type,
                       vpc_id:                   l.vpc_id }]
      end
      break unless load_balancers.next_marker
      pagination_options = { next_marker: load_balancers.next_marker }
    end
    @table = alb_rows
  end
end
