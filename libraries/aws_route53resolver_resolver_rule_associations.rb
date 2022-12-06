require 'aws_backend'

class AWSRoute53ResolverResolverRuleAssociations < AwsResourceBase
  name 'aws_route53resolver_resolver_rule_associations'
  desc 'Lists the associations that were created between Resolver rules and VPCs using the current AWS account.'

  example "
    describe aws_route53resolver_resolver_rule_associations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                 field: :id)
             .register_column(:resolver_rule_ids,                   field: :resolver_rule_id)
             .register_column(:names,                               field: :name)
             .register_column(:vpc_ids,                             field: :vpc_id)
             .register_column(:statuses,                            field: :status)
             .register_column(:status_messages,                     field: :status_message)
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
        @api_response = @aws.route53resolver_client.list_resolver_rule_associations(@query_params)
      end
      return [] if !@api_response || @api_response.empty?
      @api_response.resolver_rule_associations.each do |res|
        rows += [{
          id: res.id,
          resolver_rule_id: res.resolver_rule_id,
          name: res.name,
          vpc_id: res.vpc_id,
          status: res.status,
          status_message: res.status_message,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
