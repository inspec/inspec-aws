require "aws_backend"

class AWSEC2NetworkInsightsAnalysis < AwsResourceBase
  name "aws_ec2_network_insights_analysis"
  desc "Describes one or more of your network insights analyses."

  example "
    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { network_insights_analysis_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:network_insights_analysis_id])
    raise ArgumentError, "#{@__resource_name__}: network_insights_analysis_id must be provided" unless opts[:network_insights_analysis_id] && !opts[:network_insights_analysis_id].empty?
    @display_name = opts[:network_insights_analysis_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_network_insights_analyses({ network_insights_analysis_ids: [opts[:network_insights_analysis_id]] })
      @res = resp.network_insights_analyses[0].to_h
      create_resource_methods(@res)
    end
  end

  def network_insights_analysis_id
    return nil unless exists?
    @res[:network_insights_analysis_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:network_insights_analysis_id] : @display_name
  end

  def to_s
    "Network Insights Analysis ID: #{@display_name}"
  end
end
