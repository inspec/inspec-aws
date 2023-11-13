require 'aws_backend'

class AWSAmplifyApps < AwsResourceBase
  name 'aws_amplify_apps'
  desc 'Describes a list of Amplify App.'
  example <<-EXAMPLE
    describe aws_amplify_apps do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:app_ids, field: :app_id)
             .register_column(:app_arns, field: :app_arn)
             .register_column(:names, field: :name)
             .register_column(:tags, field: :tags)
             .register_column(:description, field: :description)
             .register_column(:repositories, field: :repository)
             .register_column(:platforms, field: :platform)
             .register_column(:create_time, field: :create_time)
             .register_column(:host_instance_types, field: :host_instance_type)
             .register_column(:update_time, field: :update_time)
             .register_column(:iam_service_role_arns, field: :iam_service_role_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    apps_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.amplify_client.list_apps(pagination_options)
      end
      return apps_rows if !@api_response || @api_response.empty?
      @api_response.apps.each do |apps|
        apps_rows += [{
          app_id: apps.app_id,
          app_arn: apps.app_arn,
          name: apps.name,
          tags: apps.tags,
          description: apps.description,
          repository: apps.repository,
          platform: apps.platform,
          create_time: apps.create_time,
          update_time: apps.update_time,
          iam_service_role_arn: apps.iam_service_role_arn,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = apps_rows
  end
end
