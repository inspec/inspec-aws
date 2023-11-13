require "aws_backend"

class AWSCloudwatchMetricStreams < AwsResourceBase
  name "aws_cloudwatch_metric_streams"
  desc "Returns a list of metric streams in this account."
  example <<-EXAMPLE
    describe aws_cloudwatch_metric_streams do
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
    .register_column(:arns, field: :arn)
    .register_column(:creation_date, field: :creation_date)
    .register_column(:last_update_date, field: :last_update_date)
    .register_column(:names, field: :name)
    .register_column(:firehose_arns, field: :firehose_arn)
    .register_column(:states, field: :state)
    .register_column(:output_formats, field: :output_format)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @cloudwatch_streams = @aws.cloudwatch_client.list_metric_streams.map do |streams|
        streams.data.entries.map { |stream| {
          arn: stream[:arn],
          creation_date: stream[:creation_date],
          last_update_date: stream[:last_update_date],
          name: stream[:name],
          firehose_arn: stream[:firehose_arn],
          state: stream[:state],
          output_format: stream[:output_format],
        }
        }
      end.flatten
    end
  end
end
