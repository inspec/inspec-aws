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
      @api_response = @aws.ecs_client.list_task_definitions(pagination_options)
    end
    return [] if !@api_response || @api_response.empty?
    @api_response.each do |res|
      table_rows += [{
        task_definition_arns: res.task_definition_arns,
      }]
    end
    @table = table_rows
  end
end
