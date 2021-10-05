# frozen_string_literal: true

require 'aws_backend'

class AWSNetworkManagerDevices < AwsResourceBase
  name 'aws_network_manager_devices'
  desc 'List all the devices.'

  example "
    describe aws_network_manager_devices do
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
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    pagination_options[:global_network_id]= opts[:global_network_id]
    # rows = []
    # loop do
    #   catch_aws_errors do
    #     @api_response = @aws.networkmanager_client.get_devices(pagination_options)
    #
    #   end
    #   return rows if !@api_response || @api_response.empty?
    #   @api_response.devices.each do |resp|
    #     require 'byebug'
    #     byebug
    #     rows += [{ device_id: resp.device_id,
    #                device_arn: resp.device_arn,
    #                global_network_id: resp.global_network_id,
    #                location_zones: resp.aws_location.zone,
    #                description: resp.description,
    #                type: resp.type,
    #                vendor: resp.vendor,
    #                model: resp.model,
    #                serial_number: resp.serial_number,
    #                address: resp.location.map { |k,v| [v] },
    #                latitude: resp.location.latitude,
    #                longitude: resp.location.longitude,
    #                site_id: resp.site_id,
    #                created_at: resp.created_at,
    #                state: resp.state,
    #                tags: resp.tags }]
    #   end
    #   break unless @api_response.next_token
    #   pagination_options[:next_token] = @api_response.next_token
    # end
    # rows
    catch_aws_errors do
      @api_response = @aws.networkmanager_client.get_devices(pagination_options).map do |device|
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
                         tags: devices.tags
        }
        }
      end.flatten
    end

  end
end
