require "aws_backend"

class AWSLogsMetricFilters < AwsResourceBase
  name "aws_logs_metric_filters"
  desc "Lists the specified metric filters."

  example "
    describe aws_logs_metric_filters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:filter_names,                                        field: :filter_name)
    .register_column(:filter_patterns,                                     field: :filter_pattern)
    .register_column(:metric_transformations,                              field: :metric_transformations)
    .register_column(:creation_times,                                      field: :creation_time)
    .register_column(:log_group_names,                                     field: :log_group_name)
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
        @api_response = @aws.cloudwatchlogs_client.describe_metric_filters(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.metric_filters.each do |res|
        rows += [{
          filter_name: res.filter_name,
          filter_pattern: res.filter_pattern,
          metric_transformations: res.metric_transformations,
          creation_time: res.creation_time,
          log_group_name: res.log_group_name,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
