# frozen_string_literal: true

require 'aws_backend'

class AWSAmplifyApp < AwsResourceBase
  name 'aws_amplify_apps'
  desc 'Describes a list of Amplify Branches.'

  example "
    describe aws_amplify_apps do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:branch_arn, field: :branch_arn)
             .register_column(:branch_names, field: :branch_name)
             .register_column(:stage, field: :stage)
             .register_column(:tags, field: :tags)
             .register_column(:description, field: :description)
             .register_column(:display_name, field: :display_name)
             .register_column(:enable_notification, field: :enable_notification)
             .register_column(:create_time, field: :create_time)
             .register_column(:update_time, field: :update_time)
             .register_column(:iam_service_role_arns, field: :iam_service_role_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: [:app_id])
    @table = fetch_data
  end

  def fetch_data
    apps_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.amplify_client.list_branches(pagination_options)
      end
      return apps_rows if !@api_response || @api_response.empty?
      @api_response.branches.each do |branches|
        apps_rows += [{
                        branch_arn: branches.branch_arn,
                        branch_name: branches.branch_name,
                        stage: branches.stage,
                        tags: branches.tags,
                        description: branches.description,
                        display_name: branches.display_name,
                        enable_notification: branches.enable_notification,
                        create_time: branches.create_time,
                        display_name: branches.display_name,
                        update_time: branches.update_time,
                        iam_service_role_arn: branches.iam_service_role_arn,

        }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = apps_rows
  end
end
