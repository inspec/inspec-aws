# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53HostedZones < AwsResourceBase
  name 'aws_route53_hosted_zones'
  desc ''
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
    catch_aws_errors do
      @resp = @aws.route53_client.list_hosted_zones
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.hosted_zones.map(&:to_h)
  end
end
