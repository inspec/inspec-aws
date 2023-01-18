require "aws_backend"

class AWSEventBridgeRules < AwsResourceBase
  name "aws_eventbridge_rules"
  desc "Lists your Amazon EventBridge rules."

  example "
    describe aws_eventbridge_rules do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:names,                           field: :name)
    .register_column(:arns,                            field: :arn)
    .register_column(:event_patterns,                  field: :event_pattern)
    .register_column(:states,                          field: :state)
    .register_column(:descriptions,                    field: :description)
    .register_column(:schedule_expressions,            field: :schedule_expression)
    .register_column(:role_arns,                       field: :role_arn)
    .register_column(:managed_bys,                     field: :managed_by)
    .register_column(:event_bus_names,                 field: :event_bus_name)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.eventbridge_client.list_rules(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.rules.each do |res|
        rows += [{ name: res.name,
                   arn: res.arn,
                   event_pattern: res.event_pattern,
                   state: res.state,
                   description: res.description,
                   schedule_expression: res.schedule_expression,
                   role_arn: res.role_arn,
                   managed_by: res.managed_by,
                   event_bus_name: res.event_bus_name }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
