require "aws_backend"

class AWSEC2NetworkInsightsPath < AwsResourceBase
  name "aws_ec2_network_insights_path"
  desc "Returns"

  example "
    describe aws_ec2_network_insights_path(network_insights_path_id: 'NetworkInsightsPathId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { network_insights_path_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:network_insights_path_id])
    raise ArgumentError, "#{@__resource_name__}: network_insights_path_id must be provided" unless opts[:network_insights_path_id] && !opts[:network_insights_path_id].empty?
    @display_name = opts[:network_insights_path_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_network_insights_paths({ network_insights_path_ids: [opts[:network_insights_path_id]] })
      @res = resp.network_insights_paths[0].to_h
      create_resource_methods(@res)
    end
  end

  def network_insights_path_id
    return nil unless exists?
    @res[:network_insights_path_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:network_insights_path_id] : @display_name
  end

  def to_s
    "Network Insights Path ID: #{@display_name}"
  end
end
