require 'aws_backend'

class AWSNetworkManagerDevices < AwsResourceBase
  name 'aws_network_manager_devices'
  desc 'List all the devices.'

  example "
    describe aws_network_manager_devices(global_network_id: 'GlobalNetworkID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:device_ids, field: :device_id)
             .register_column(:device_arns, field: :device_arn)
             .register_column(:global_network_ids, field: :global_network_id)
             .register_column(:location_zones, field: :location_zones, style: :simple)
             .register_column(:location_subnet_arns, field: :location_subnet_arn, style: :simple)
             .register_column(:descriptions, field: :description)
             .register_column(:types, field: :type)
             .register_column(:vendors, field: :vendor)
             .register_column(:models, field: :model)
             .register_column(:serial_numbers, field: :serial_number)
             .register_column(:addresses, field: :address, style: :simple)
             .register_column(:latitudes, field: :latitude, style: :simple)
             .register_column(:longitudes, field: :longitude, style: :simple)
             .register_column(:site_ids, field: :site_id)
             .register_column(:created_at, field: :created_at)
             .register_column(:states, field: :state)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: [:global_network_id])
    raise ArgumentError, "#{@__resource_name__}: global_network_id must be provided" unless opts[:global_network_id] && !opts[:global_network_id].empty?
    @table = fetch_data
  end

  def fetch_data
    query_params = {}
    query_params[:global_network_id]= opts[:global_network_id]
    catch_aws_errors do
      @api_response = @aws.network_manager_client.get_devices(query_params).map do |device|
        device.devices.map { |devices| {
          device_id: devices.device_id,
          device_arn: devices.device_arn,
          global_network_id: devices.global_network_id,
          location_zones: devices.aws_location.zone,
          location_subnet_arn: devices.aws_location.subnet_arn,
          description: devices.description,
          type: devices.type,
          vendor: devices.vendor,
          model: devices.model,
          serial_number: devices.serial_number,
          address: devices.location.address,
          latitude: devices.location.latitude,
          longitude: devices.location.longitude,
          site_id: devices.site_id,
          created_at: devices.created_at,
          state: devices.state,
          tags: devices.tags,
        }
        }
      end.flatten
    end
  end
end
