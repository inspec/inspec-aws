require 'aws_backend'

class AWSEC2Hosts < AwsResourceBase
  name 'aws_ec2_hosts'
  desc 'Describes the specified Dedicated Hosts or all your Dedicated Hosts.'

  example "
    describe aws_ec2_hosts do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:auto_placements, field: :auto_placement)
             .register_column(:availability_zones, field: :availability_zone)
             .register_column(:available_capacities, field: :available_capacity)
             .register_column(:client_tokens, field: :client_token)
             .register_column(:host_ids, field: :host_id)
             .register_column(:host_properties, field: :host_properties)
             .register_column(:instances, field: :instances)
             .register_column(:states, field: :state)
             .register_column(:allocation_times, field: :allocation_time)
             .register_column(:tags, field: :tags)
             .register_column(:host_recoveries, field: :host_recovery)
             .register_column(:allows_multiple_instance_types, field: :allows_multiple_instance_types)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:availability_zone_ids, field: :availability_zone_id)
             .register_column(:member_of_service_linked_resource_groups, field: :member_of_service_linked_resource_group)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_hosts(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.hosts.each do |res|
        rows += [{ auto_placement: res.auto_placement,
                   availability_zone: res.availability_zone,
                   available_capacity: res.available_capacity,
                   client_token: res.client_token,
                   host_id: res.host_id,
                   host_properties: res.host_properties,
                   instances: res.instances,
                   state: res.state,
                   allocation_time: res.allocation_time,
                   release_time: res.release_time,
                   tags: res.tags,
                   host_recovery: res.host_recovery,
                   allows_multiple_instance_types: res.allows_multiple_instance_types,
                   owner_id: res.owner_id,
                   availability_zone_id: res.availability_zone_id,
                   member_of_service_linked_resource_group: res.member_of_service_linked_resource_group }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end
