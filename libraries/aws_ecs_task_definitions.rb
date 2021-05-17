# frozen_string_literal: true

require 'aws_backend'

class AWSECSTaskDefinitions < AwsResourceBase
  name 'aws_ecs_task_definitions'
  desc 'Returns a list of task definitions that are registered to your account. You can filter the results by family name with the familyPrefix parameter or by status with the status parameter.'
  example `
    describe aws_ecs_task_definitions do
      it { should exist }
    end
  `
  attr_reader :table

  FilterTable.create
             .register_column(:task_definition_arns, field: :task_definition_arns)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    table_rows = []
    pagination_options = {}

    catch_aws_errors do
      @resp = @aws.ecs_client.describe_services
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.services.map(&:to_h)
    catch_aws_errors do
      resp = @aws.ecs_client.describe_services({ cluster: opts[:cluster], services: opts[:services] })
      @services = resp.services[0].to_h
      create_resource_methods(@services)
    end
    catch_aws_errors do
      @api_response = @aws.ecs_client.list_services(pagination_options)
    end
    return [] if !@api_response || @api_response.empty?
    @api_response.each do |compute_environment|
      table_rows += [{
        task_definition_arns: compute_environment.task_definition_arns,
      }]
    end
    # break unless @api_response.next_token
    # pagination_options = { next_token: @api_response.next_token }
    @table = table_rows
  end
end
