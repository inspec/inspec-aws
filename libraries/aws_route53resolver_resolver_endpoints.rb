require 'aws_backend'

class AWSRoute53ResolverResolverEndpoints < AwsResourceBase
  name 'aws_route53resolver_resolver_endpoints'
  desc 'Lists all the Resolver endpoints that were created using the current AWS account.'

  example "
    describe aws_route53resolver_resolver_endpoints do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                                   field: :id)
             .register_column(:creator_request_ids,                                   field: :creator_request_id)
             .register_column(:arns,                                                  field: :arn)
             .register_column(:names,                                                 field: :name)
             .register_column(:security_group_ids,                                    field: :security_group_ids)
             .register_column(:directions,                                            field: :direction)
             .register_column(:ip_address_counts,                                     field: :ip_address_count)
             .register_column(:host_vpc_ids,                                          field: :host_vpc_id)
             .register_column(:statuses,                                              field: :status)
             .register_column(:status_messages,                                       field: :status_message)
             .register_column(:creation_times,                                        field: :creation_time)
             .register_column(:modification_times,                                    field: :modification_time)
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
        @api_response = @aws.route53resolver_client.list_resolver_endpoints(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.resolver_endpoints.each do |res|
        rows += [{
          id: res.id,
          creator_request_id: res.creator_request_id,
          arn: res.arn,
          name: res.name,
          security_group_ids: res.security_group_ids,
          direction: res.direction,
          ip_address_count: res.ip_address_count,
          host_vpc_id: res.host_vpc_id,
          status: res.status,
          status_message: res.status_message,
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
