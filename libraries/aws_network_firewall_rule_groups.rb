require 'aws_backend'

class AWSNetworkFirewallRuleGroups < AwsResourceBase
  name 'aws_network_firewall_rule_groups'
  desc 'Retrieves the metadata for the rule groups that you have defined.'

  example "
    describe aws_network_firewall_rule_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:names, field: :name)
             .register_column(:arns, field: :arn)
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
        @api_response = @aws.network_firewall_client.list_rule_groups(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.rule_groups.each do |resp|
        rows += [{ name: resp.name,
                   arn: resp.arn }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
