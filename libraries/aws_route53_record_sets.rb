require 'aws_backend'

class AWSRoute53RecordSets < AwsResourceBase
  name 'aws_route53_record_sets'
  desc 'Lists the resource record sets in a specified hosted zone.'

  example "
    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:names,                                       field: :name)
             .register_column(:types,                                       field: :type)
             .register_column(:set_identifiers,                             field: :set_identifier)
             .register_column(:weights,                                     field: :weight)
             .register_column(:regions,                                     field: :region)
             .register_column(:geo_locations,                               field: :geo_location)
             .register_column(:failovers,                                   field: :failover)
             .register_column(:multi_value_answers,                         field: :multi_value_answer)
             .register_column(:ttls,                                        field: :ttl)
             .register_column(:resource_records,                            field: :resource_records, style: :simple)
             .register_column(:alias_targets,                               field: :alias_target)
             .register_column(:health_check_ids,                            field: :health_check_id)
             .register_column(:traffic_policy_instance_ids,                 field: :traffic_policy_instance_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(hosted_zone_id))
    @query_params = {}
    @query_params[:hosted_zone_id] = opts[:hosted_zone_id]
    if opts.key?(:hosted_zone_id)
      raise ArgumentError, "#{@__resource_name__}: hosted_zone_id must be provided" unless opts[:hosted_zone_id] && !opts[:hosted_zone_id].empty?
      @query_params[:hosted_zone_id] = opts[:hosted_zone_id]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.route53_client.list_resource_record_sets(@query_params).map do |table|
        table.resource_record_sets.map { |table_items| {
          name: table_items.name,
          type: table_items.type,
          set_identifier: table_items.set_identifier,
          weight: table_items.weight,
          region: table_items.region,
          geo_location: table_items.geo_location,
          failover: table_items.failover,
          multi_value_answer: table_items.multi_value_answer,
          ttl: table_items.ttl,
          resource_records: table_items.resource_records.map(&:value),
          alias_target: table_items.alias_target,
          health_check_id: table_items.health_check_id,
          traffic_policy_instance_id: table_items.traffic_policy_instance_id,
        }
        }
      end.flatten
    end
  end
end
