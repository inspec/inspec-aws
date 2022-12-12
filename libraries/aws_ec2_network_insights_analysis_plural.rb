require "aws_backend"

class AWSEC2NetworkInsightsAnalysisPlural < AwsResourceBase
  name "aws_ec2_network_insights_analysis_plural"
  desc "List all the network insights analyses."

  example "
    describe aws_ec2_network_insights_analysis_plural do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:network_insights_analysis_ids, field: :network_insights_analysis_id)
    .register_column(:network_insights_analysis_arns, field: :network_insights_analysis_arn)
    .register_column(:network_insights_path_ids, field: :network_insights_path_id)
    .register_column(:filter_in_arns, field: :filter_in_arns)
    .register_column(:start_dates, field: :start_date)
    .register_column(:statuses, field: :status)
    .register_column(:status_messages, field: :status_message)
    .register_column(:network_path_found, field: :network_path_found)
    .register_column(:forward_path_components, field: :forward_path_components)
    .register_column(:return_path_components, field: :return_path_components)
    .register_column(:explanations, field: :explanations)
    .register_column(:alternate_path_hints, field: :alternate_path_hints)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_network_insights_analyses(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.network_insights_analyses.each do |resp|
        rows += [{ network_insights_analysis_id: resp.network_insights_analysis_id,
                   network_insights_analysis_arn: resp.network_insights_analysis_arn,
                   network_insights_path_id: resp.network_insights_path_id,
                   filter_in_arns: resp.filter_in_arns,
                   start_date: resp.start_date,
                   status: resp.status,
                   status_message: resp.status_message,
                   network_path_found: resp.network_path_found,
                   forward_path_components: resp.forward_path_components,
                   return_path_components: resp.return_path_components,
                   explanations: resp.explanations,
                   alternate_path_hints: resp.alternate_path_hints,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
