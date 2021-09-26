# frozen_string_literal: true

require 'aws_backend'

class AWSAmplifyBranches < AwsResourceBase
  name 'aws_amplify_branches'
  desc 'Lists the branches of an Amplify app.'

  example "
    describe aws_amplify_branches(app_id: 'AppId') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:branch_arns, field: :branch_arn)
             .register_column(:branch_names, field: :branch_name)
             .register_column(:stages, field: :stage)
             .register_column(:tags, field: :tags)
             .register_column(:descriptions, field: :description)
             .register_column(:display_names, field: :display_name)
             .register_column(:enable_notifications, field: :enable_notification)
             .register_column(:create_time, field: :create_time)
             .register_column(:update_time, field: :update_time)
             .register_column(:iam_service_role_arns, field: :iam_service_role_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(app_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: app_id must be provided" unless opts[:app_id] && !opts[:app_id].empty?
    @query_params[:app_id] = opts[:app_id]
    @table = fetch_data
  end

  def fetch_data
    apps_rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.amplify_client.list_branches(@query_params)
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
                        update_time: branches.update_time,
                        iam_service_role_arn: branches.iam_service_role_arn,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    @table = apps_rows
  end
end
