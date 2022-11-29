require 'aws_backend'

class AwsLaunchConfigurations < AwsResourceBase
  name 'aws_launch_configurations'
  desc 'Verifies settings for a collection AWS Launch Configurations.'
  example "
    describe aws_launch_configurations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                          field: :arn)
             .register_column(:names,                         field: :name)
             .register_column(:image_ids,                     field: :image_id)
             .register_column(:instance_types,                field: :instance_type)
             .register_column(:iam_instance_profiles,         field: :iam_instance_profile)
             .register_column(:key_names,                     field: :key_name)
             .register_column(:security_groups,               field: :security_groups)
             .register_column(:associate_public_ip_addresses, field: :associate_public_ip_address)
             .register_column(:ebs_optimizeds,                field: :ebs_optimized)
             .register_column(:spot_prices,                   field: :spot_price)
             .register_column(:instance_monitoring,           field: :instance_monitoring)
             .register_column(:user_data,                     field: :user_data)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    config_rows = []
    catch_aws_errors do
      response = @aws.service_client.describe_launch_configurations
      return [] if !response || response.empty?
      response.launch_configurations.each do |config|
        config_rows += [{ name:                       config[:launch_configuration_name],
                         arn:                         config[:launch_configuration_arn],
                         image_id:                    config[:image_id],
                         instance_type:               config[:instance_type],
                         iam_instance_profile:        config[:iam_instance_profile],
                         key_name:                    config[:key_name],
                         security_groups:             config[:security_groups],
                         associate_public_ip_address: config[:associate_public_ip_address].nil? ? false : true,
                         ebs_optimized:               config[:ebs_optimized],
                         spot_price:                  config[:spot_price].to_f,
                         instance_monitoring:         config[:instance_monitoring][:enabled] ? 'detailed': 'basic',
                         user_data:                   config[:user_data] ? Base64.decode64(config[:user_data]) : nil }]
      end
    end
    @table = config_rows
  end
end
