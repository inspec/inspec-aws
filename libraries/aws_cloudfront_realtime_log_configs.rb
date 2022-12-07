require 'aws_backend'

class AwsCloudFrontRealtimeLogConfigs < AwsResourceBase
  name 'aws_cloudfront_realtime_log_configs'
  desc 'Gets a list of real-time log configurations.'

  example "
    describe aws_cloudfront_realtime_log_configs do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns, field: :arn)
             .register_column(:names, field: :name)
             .register_column(:sampling_rates, field: :sampling_rate)
             .register_column(:end_points, field: :end_points)
             .register_column(:fields, field: :fields)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudfront_client.list_realtime_log_configs.map do |table|
        table.realtime_log_configs.items.map { |table_name| {
          arn: table_name.arn,
          name: table_name.name,
          sampling_rate: table_name.sampling_rate,
          end_points: table_name.end_points,
          fields: table_name.fields,
        }
        }
      end.flatten
    end
  end
end
