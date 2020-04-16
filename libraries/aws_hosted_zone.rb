# frozen_string_literal: true

require 'aws_backend'

class AwsHostedZone < AwsResourceBase
  name 'aws_hosted_zone'
  desc 'Verifies hosted zone settings are correct'

  example "
    describe aws_hosted_zone('zone-name') do
      it { should exist }
      its ('name_servers.count') { should eq 4 }
      its ('private_zone') { should be false }
      its ('record_names') { should include 'sid-james.carry-on.films.com' }
    end
  "

  attr_reader :name_servers, :private_zone, :record_count, :records

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

    get_zone_id(opts[:zone_name])

    get_zone_details(@id) if !@id.nil?

    get_zone_record(@id) if !@id.nil?
  end

  def exist?
    !@id.nil?
  end

  private

  def get_zone_id(zone_name)
    catch_aws_errors do
      resp = @aws.route53_client.list_hosted_zones

      zone = resp.hosted_zones.find { |item| item.name==zone_name }

      if zone.nil?
        return @id = nil
      end

      @id = zone.id
    end
  end

  def get_zone_details(zone_id)
    catch_aws_errors do

      resp = @aws.route53_client.get_hosted_zone(id: zone_id)

      if !resp[:delegation_set].nil? && !resp[:delegation_set][:name_servers].nil?
        @name_servers = resp[:delegation_set][:name_servers]
      else
        @name_servers = []
      end

      @private_zone = resp[:hosted_zone][:config][:private_zone]
      @record_count = resp[:hosted_zone][:resource_record_set_count]

    end
  end

  def get_zone_record(zone_id)
    resp = nil
    catch_aws_errors do

      resp = @aws.route53_client.list_resource_record_sets(hosted_zone_id: zone_id)
    end

    records_rows = []
    resp[:resource_record_sets].each do |item|
      item.resource_records.each do |record|
        records_rows +=[{ record_name:  item.name,
            id:  @id,
            type:  item.type,
            value:  record.value,
            ttl:  item.ttl }]
      end
    end
    @records = records_rows
  end
end
