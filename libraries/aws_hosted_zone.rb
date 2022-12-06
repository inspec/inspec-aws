require 'aws_backend'

class AwsHostedZone < AwsResourceBase
  name 'aws_hosted_zone'
  desc 'Verifies hosted zone settings are correct.'

  example "
    describe aws_hosted_zone('zone-name') do
      it { should exist }
      its ('name_servers.count') { should eq 4 }
      its ('private_zone') { should be false }
      its ('record_names') { should include 'sid-james.carry-on.films.com' }
    end
  "

  attr_reader :records

  FilterTable.create
             .register_column(:record_names,      field: :record_name)
             .register_column(:ids,               field: :id)
             .register_column(:private,           field: :private)
             .register_column(:ttls,              field: :ttl)
             .register_column(:types,             field: :type)
             .register_column(:values,            field: :value)
             .install_filter_methods_on_resource(self, :records)

  def initialize(opts = {})
    opts = { zone_name: opts } if opts.is_a?(String)
    super(opts)

    validate_parameters(required: [:zone_name])
    @id = get_zone_id
    @records = get_zone_records
  end

  def exist?
    !@id.blank?
  end

  def name_servers
    zone_details&.dig(:delegation_set, :name_servers).presence || []
  end

  def private_zone
    zone_details&.dig(:hosted_zone, :config, :private_zone)
  end

  def record_count
    zone_details&.dig(:hosted_zone, :resource_record_set_count)
  end

  private

  def get_zone_id
    resp = catch_aws_errors do
      route53_client.list_hosted_zones
    end
    return unless resp

    zone = resp.hosted_zones.find { |item| item.name== opts[:zone_name] }
    zone&.id
  end

  def zone_details
    return unless @id

    @zone_details ||= catch_aws_errors do
      route53_client.get_hosted_zone(id: @id)
    end
  end

  def get_zone_records
    return {} unless zone_record_sets

    zone_record_sets.resource_record_sets.flat_map do |item|
      item.resource_records.flat_map do |record|
        {
          record_name:  item.name,
          id: @id,
          type: item.type,
          value: record.value,
          ttl: item.ttl,
        }
      end
    end
  end

  def zone_record_sets
    @zone_record_sets ||= catch_aws_errors do
      route53_client.list_resource_record_sets(hosted_zone_id: @id)
    end
  end

  def route53_client
    @aws.route53_client
  end
end
