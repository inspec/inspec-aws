# frozen_string_literal: true

require 'aws_backend'

class AwsCloudFrontKeyGroups < AwsResourceBase
  name 'aws_cloud_front_key_groups'
  desc 'Describes one or more of Key Group.'

  example "
    describe aws_cloud_front_key_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:id, field: :id)
             .register_column(:last_modified_time, field: :last_modified_time)
             .register_column(:key_group_config_names, field: :key_group_config_name)
             .register_column(:key_group_config_items, field: :key_group_config_items, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.cloudfront_client.list_key_groups.map do |table|
        table.key_group_list.items.map { |table_name| {
          id: table_name.id,
          last_modified_time: table_name.last_modified_time,
          key_group_config_name: table_name.key_group_config.name,
          key_group_config_items: table_name.key_group_config.items,
        }
        }
      end.flatten
    end
  end
end
