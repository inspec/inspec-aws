require "aws_backend"

class AWSNetworkFirewallFirewalls < AwsResourceBase
  name "aws_network_firewall_firewalls"
  desc "Retrieves the metadata for the firewalls that you have defined."

  example "
    describe aws_network_firewall_firewalls do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:firewall_names, field: :firewall_name)
    .register_column(:firewall_arns, field: :firewall_arn)
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
        @api_response = @aws.network_firewall_client.list_firewalls(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.firewalls.each do |resp|
        rows += [{ firewall_name: resp.firewall_name,
                   firewall_arn: resp.firewall_arn }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
