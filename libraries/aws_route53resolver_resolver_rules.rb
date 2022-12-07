require 'aws_backend'

class AWSRoute53ResolverResolverRules < AwsResourceBase
  name 'aws_route53resolver_resolver_rules'
  desc 'Lists the Resolver rules that were created using the current AWS account.'

  example "
    describe aws_route53resolver_resolver_rules do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                     field: :id)
             .register_column(:creator_request_ids,                     field: :creator_request_id)
             .register_column(:arns,                                    field: :arn)
             .register_column(:domain_names,                            field: :domain_name)
             .register_column(:statuses,                                field: :status)
             .register_column(:status_messages,                         field: :status_message)
             .register_column(:rule_types,                              field: :rule_type)
             .register_column(:names,                                   field: :name)
             .register_column(:target_ips,                              field: :target_ips)
             .register_column(:resolver_endpoint_ids,                   field: :resolver_endpoint_id)
             .register_column(:owner_ids,                               field: :owner_id)
             .register_column(:share_statuses,                          field: :share_status)
             .register_column(:creation_times,                          field: :creation_time)
             .register_column(:modification_times,                      field: :modification_time)
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
        @api_response = @aws.route53resolver_client.list_resolver_rules(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.resolver_rules.each do |res|
        rows += [{
          id: res.id,
          creator_request_id: res.creator_request_id,
          arn: res.arn,
          domain_name: res.domain_name,
          status: res.status,
          status_message: res.status_message,
          rule_type: res.rule_type,
          name: res.name,
          target_ips: res.target_ips,
          resolver_endpoint_id: res.resolver_endpoint_id,
          owner_id: res.owner_id,
          share_status: res.share_status,
          creation_time: res.creation_time,
          modification_time: res.modification_time,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
