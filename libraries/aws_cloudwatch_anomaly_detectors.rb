require 'aws_backend'

class AwsCloudwatchAnomalyDetectors < AwsResourceBase
  name 'aws_cloudwatch_anomaly_detectors'
  desc 'Lists the anomaly detection models that you have created in your account.'

  example "
    describe aws_cloudwatch_anomaly_detectors do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:namespaces, field: :namespace)
             .register_column(:metric_names, field: :metric_name)
             .register_column(:dimensions, field: :dimensions)
             .register_column(:stats, field: :stat)
             .register_column(:configurations, field: :configuration)
             .register_column(:state_values, field: :state_value)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudwatch_client.describe_anomaly_detectors.map do |table|
        table.anomaly_detectors.map { |table_name| {
          namespace: table_name.namespace,
          metric_name: table_name.metric_name,
          dimensions: table_name.dimensions,
          stat: table_name.stat,
          configuration: table_name.configuration,
          state_value: table_name.state_value,
        }
        }
      end.flatten
    end
  end
end
