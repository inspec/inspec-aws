require "aws_backend"

class AWSCloudwatchDashboards < AwsResourceBase
  name "aws_cloudwatch_dashboards"
  desc "Verifies settings for Cloudwatch Dashboard in bulk."
  example <<-EXAMPLE
    describe aws_cloudwatch_dashboards do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
    .register_column(:dashboard_names, field: :dashboard_name)
    .register_column(:dashboard_arns, field: :dashboard_arn)
    .register_column(:last_modified, field: :last_modified)
    .register_column(:sizes, field: :size)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @cloudwatch_dashboards = @aws.cloudwatch_client.list_dashboards.map do |dashboards|
        dashboards.dashboard_entries.map { |cloudwatch_dashboards| {
          dashboard_name: cloudwatch_dashboards[:dashboard_name],
          dashboard_arn: cloudwatch_dashboards[:dashboard_arn],
          last_modified: cloudwatch_dashboards[:last_modified],
          size: cloudwatch_dashboards[:size],
        }
        }
      end.flatten
    end
  end
end
