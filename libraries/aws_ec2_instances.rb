require 'aws_backend'

class AwsEc2Instances < AwsResourceBase
  name 'aws_ec2_instances'
  desc 'Verifies settings for a collection of AWS EC2 Instances.'
  example "
    describe aws_ec2_instances do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:instance_ids,   field: :instance_id)
             .register_column(:names,          field: :name)
             .register_column(:vpc_ids,        field: :vpc_id)
             .register_column(:subnet_ids,     field: :subnet_id)
             .register_column(:instance_types, field: :instance_type)
             .register_column(:tags,           field: :tags)
             .register_column(:iam_profiles,   field: :iam_profile)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    instance_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_instances(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?
      @api_response.reservations.each do |res|
        res.instances.each do |instance|
          instance_tags = map_tags(instance.tags)
          instance_rows += [{
            instance_id: instance.instance_id,
            vpc_id: instance.vpc_id,
            subnet_id: instance.subnet_id,
            instance_type: instance.instance_type,
            tags: instance_tags,
            name: instance_tags['Name'],
            iam_profile: instance.iam_instance_profile&.arn&.split('/')&.last,
          }]
        end
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = instance_rows
  end
end
