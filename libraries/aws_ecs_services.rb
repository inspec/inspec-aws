# frozen_string_literal: true

require 'aws_backend'

class AWSECSServices < AwsResourceBase
  name 'aws_ecs_services'
  desc 'Lists the clients that have been created for the specified user pool.'

  example "
    describe aws_ecs_services(user_pool_id: 'test1') do
      its('count') { should eq 3 }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:client_ids,                      field: :client_id)
             .register_column(:user_pool_ids,                   field: :user_pool_id)
             .register_column(:client_names,                    field: :client_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    @resp = @aws.ecs_client.list_services
    return [] if !@resp || @resp.empty?
    @table = @resp.endpoints.map(&:to_h)
  end
end
