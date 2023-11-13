require 'aws_backend'

class AWSStepFunctionsStateMachines < AwsResourceBase
  name 'aws_stepfunctions_state_machines'
  desc 'Lists the existing state machines.'

  example "
    describe aws_stepfnctions_state_machines do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:state_machine_arns,                      field: :state_machine_arn)
             .register_column(:names,                                   field: :name)
             .register_column(:types,                                   field: :type)
             .register_column(:creation_dates,                          field: :creation_date)
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
        @api_response = @aws.states_client.list_state_machines(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.state_machines.each do |res|
        rows += [{
          state_machine_arn: res.state_machine_arn,
          name: res.name,
          type: res.type,
          creation_date: res.creation_date,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
