require 'aws_backend'

class AwsHostedZone < AwsResourceBase
  name 'aws_hosted_zone'
  desc 'Verifies hosted zone settings are correct'

  example "
    describe aws_hosted_zone('zone-name') do
      it { should exist }

    end
  "
  attr_reader :records, :name_servers, :private, :record_count

  FilterTable.create
             .register_column(:name,        field: :name)
             .register_column(:id,          field: :id)
             .register_column(:private,     field: :private)
             .register_column(:ttl,         field: :ttl)
             .register_column(:type,        field: :type)
             .register_column(:value,       field: :value)
             .install_filter_methods_on_resource(self, :records)

  def initialize(opts = {})
    opts = { zone_name: opts } if opts.is_a?(String)
    super(opts)

    validate_parameters(required: [:zone_name])

    get_zone_id(opts[:zone_name])

    get_zone_details(@id)

    record_list = get_records_for_zone(@id)

    @record_count = record_list.length

    records_rows = []
    record_list.each do |item|
      item.resource_records.each do |record|
        records_rows += [{
          name:    item.name,
          id:      @id,
          type:    item.type,
          value:   record.value,
          ttl:     item.ttl,
        }]
      end
    end
    @records = records_rows
  end

  def get_zone_id(zone_name)
    catch_aws_errors do
      resp =@aws.route53_client.list_hosted_zones

      zone = resp.hosted_zones.find { |item| item.name==zone_name }

      @id = zone.id
    end
  end

  def get_zone_details(zone_id)
    catch_aws_errors do

      resp = @aws.route53_client.get_hosted_zone(id: zone_id)
      @name_servers = resp[:delegation_set][:name_servers]
      @private = resp[:hosted_zone][:config][:private_zone]

    end
  end

  def get_records_for_zone(zone_id)
    resp = nil
    catch_aws_errors do

      resp = @aws.route53_client.list_resource_record_sets(hosted_zone_id: zone_id)
    end

    resp[:resource_record_sets]
  end
end
