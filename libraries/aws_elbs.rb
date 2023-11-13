require 'aws_backend'

class AwsElbs < AwsResourceBase
  name 'aws_elbs'
  desc 'Verifies settings for a collection AWS Elastic Load Balancers.'
  example "
    describe aws_elbs do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:availability_zones,  field: :availability_zones)
             .register_column(:dns_names,           field: :dns_name)
             .register_column(:load_balancer_names, field: :load_balancer_name)
             .register_column(:external_ports,      field: :external_ports)
             .register_column(:instance_ids,        field: :instance_ids)
             .register_column(:internal_ports,      field: :internal_ports)
             .register_column(:security_group_ids,  field: :security_group_ids)
             .register_column(:subnet_ids,          field: :subnet_ids)
             .register_column(:vpc_ids,             field: :vpc_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    elb_rows = []
    load_balancers = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        load_balancers = @aws.elb_client.describe_load_balancers(pagination_options)
      end
      return [] if !load_balancers || load_balancers.empty?

      load_balancers.load_balancer_descriptions.each do |l|
        elb_rows += [{ availability_zones:   l.availability_zones,
                       dns_name:             l.dns_name,
                       load_balancer_name:   l.load_balancer_name,
                       external_ports:       l.listener_descriptions.map { |p| p.listener.load_balancer_port },
                       instance_ids:         l.instances.map(&:instance_id),
                       internal_ports:       l.listener_descriptions.map { |p| p.listener.instance_port },
                       security_group_ids:   l.security_groups,
                       subnet_ids:           l.subnets,
                       vpc_id:               l.vpc_id }]
      end
      break unless load_balancers.next_marker
      pagination_options = { next_marker: load_balancers.next_marker }
    end
    @table = elb_rows
  end
end
