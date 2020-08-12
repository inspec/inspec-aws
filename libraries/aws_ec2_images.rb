# frozen_string_literal: true

require 'aws_backend'

class AwsEc2Images < AwsResourceBase
  name 'aws_ec2_images'
  desc 'Verifies settings for a collection of AWS EC2 Images'
  example '
    describe aws_ec2_images do
      it { should exist }
    end
  '

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:architectures,         field: :architecture)
             .register_column(:creation_dates,        field: :creation_date)
             .register_column(:image_ids,             field: :image_id)
             .register_column(:image_locations,       field: :image_location)
             .register_column(:image_types,           field: :image_type)
             .register_column(:public,                field: :public)
             .register_column(:kernal_ids,            field: :kernal_id)
             .register_column(:owner_ids,             field: :owner_id)
             .register_column(:platforms,             field: :platform)
             .register_column(:platform_details,      field: :platform_details)
             .register_column(:usage_operations,      field: :usage_operation)
             .register_column(:product_codes,         field: :product_codes)
             .register_column(:ramdisk_ids,           field: :ramdisk_id)
             .register_column(:states,                field: :state)
             .register_column(:block_device_mappings, field: :block_device_mappings)
             .register_column(:descriptions,          field: :description)
             .register_column(:ena_support,           field: :ena_support)
             .register_column(:hypervisors,           field: :hypervisor)
             .register_column(:image_owner_alias,     field: :image_owner_alias)
             .register_column(:names,                 field: :name)
             .register_column(:root_device_names,     field: :root_device_name)
             .register_column(:root_device_types,     field: :root_device_type)
             .register_column(:sriov_net_support,     field: :sriov_net_support)
             .register_column(:state_reasons,         field: :state_reason)
             .register_column(:tags,                  field: :tags)
             .register_column(:virtualization_types,  field: :virtualization_type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    image_rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_images
      end
      return [] if !api_response || api_response.empty?
      api_response.images.each do |image|
        image_rows += [{ architecture:          image.architecture,
                         creation_date:         image.creation_date,
                         image_id:              image.image_id,
                         image_location:        image.image_location,
                         image_type:            image.image_type,
                         public:                image.public,
                         kernel_id:             image.kernel_id,
                         owner_id:              image.owner_id,
                         platform:              image.platform,
                         platform_details:      image.platform_details,
                         usage_operation:       image.usage_operation,
                         product_codes:         image.product_codes,
                         ramdisk_id:            image.ramdisk_id,
                         state:                 image.state,
                         block_device_mappings: image.block_device_mappings,
                         description:           image.description,
                         ena_support:           image.ena_support,
                         hypervisor:            image.hypervisor,
                         image_owner_alias:     image.image_owner_alias,
                         name:                  image.name,
                         root_device_name:      image.root_device_name,
                         root_device_type:      image.root_device_type,
                         sriov_net_support:     image.sriov_net_support,
                         state_reason:          image.state_reason,
                         tags:                  image.tags,
                         virtualization_type:   image.virtualization_type }]
      end
      break
    end
    @table = image_rows
  end
end
