require "aws_backend"

class AWSEC2NetworkInsightsPaths < AwsResourceBase
  name "aws_ec2_network_insights_paths"
  desc "List all the network insights paths."

  example "
    describe aws_ec2_network_insights_paths do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:network_insights_path_ids, field: :network_insights_path_id)
    .register_column(:network_insights_path_arns, field: :network_insights_path_arn)
    .register_column(:created_dates, field: :created_date)
    .register_column(:sources, field: :source)
    .register_column(:destinations, field: :destination)
    .register_column(:source_ips, field: :source_ip)
    .register_column(:destination_ips, field: :destination_ip)
    .register_column(:protocols, field: :protocol)
    .register_column(:destination_ports, field: :destination_port)
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
        @api_response = @aws.compute_client.describe_network_insights_paths(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.network_insights_paths.each do |resp|
        rows += [{ network_insights_path_id: resp.network_insights_path_id,
                   network_insights_path_arn: resp.network_insights_path_arn,
                   created_date: resp.created_date,
                   source: resp.source,
                   destination: resp.destination,
                   source_ip: resp.source_ip,
                   destination_ip: resp.destination_ip,
                   protocol: resp.protocol,
                   destination_port: resp.destination_port,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
