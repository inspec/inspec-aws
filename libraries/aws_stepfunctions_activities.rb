require "aws_backend"

class AWSStepFunctionsActivities < AwsResourceBase
  name "aws_stepfunctions_activities"
  desc "Retrieves a task in the maintenance window."

  example "
    describe aws_stepfunctions_activities do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:activity_arns, field: :activity_arn)
    .register_column(:names, field: :name)
    .register_column(:creation_dates, field: :creation_date)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.states_client.list_activities.map do |table|
        table.activities.map { |table_name| {
          activity_arn: table_name.activity_arn,
          name: table_name.name,
          creation_date: table_name.creation_date,
        }
        }
      end.flatten
    end
  end
end
