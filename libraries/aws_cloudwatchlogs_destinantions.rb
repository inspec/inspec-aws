require 'aws_backend'

class AWSCloudWatchLogsDestinations < AwsResourceBase
  name 'aws_cloudwatchlogs_destinations'
  desc 'Lists all cloudwatchlogs destinations.'
  example <<-EXAMPLE
    describe aws_cloudwatchlogs_destinations do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:destination_names, field: :destination_name)
             .register_column(:target_arns, field: :target_arn)
             .register_column(:role_arns, field: :role_arn)
             .register_column(:access_policies, field: :access_policy)
             .register_column(:arns, field: :arn)
             .register_column(:creation_time, field: :creation_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudwatchlogs_client.describe_destinations.map do |table|
        table.destinations.map { |table_name| {
          destination_name: table_name.destination_name,
          target_arn: table_name.target_arn,
          role_arn: table_name.role_arn,
          access_policy: table_name.access_policy,
          creation_time: table_name.creation_time,
          arn: table_name.arn,
        }
        }
      end.flatten
    end
  end
end
