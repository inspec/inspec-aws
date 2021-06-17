# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53HostedZones < AwsResourceBase
  name 'aws_route53_hosted_zones'
  desc 'Retrieves a list of the public and private hosted zones that are associated with the current AWS account.'

  example "
    describe aws_route53_hosted_zones do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                                     field: :id)
             .register_column(:names,                                                   field: :name)
             .register_column(:caller_references,                                       field: :caller_reference)
             .register_column(:configs,                                                 field: :config)
             .register_column(:resource_record_set_counts,                              field: :resource_record_set_count)
             .register_column(:linked_services,                                         field: :linked_service)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_items] = 10
    loop do
      catch_aws_errors do
        @api_response = @aws.route53_client.list_hosted_zones(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.hosted_zones.each do |resp|
        rows += [{ id: resp.id,
                   name: resp.name,
                   caller_reference: resp.caller_reference,
                   config: resp.config,
                   resource_record_set_count: resp.resource_record_set_count,
                   linked_service: resp.linked_service }]
      end
      break unless @api_response.next_marker
      pagination_options[:marker] = @api_response.next_marker
    end
    rows
  end
end
