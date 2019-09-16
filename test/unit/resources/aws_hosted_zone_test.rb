require 'aws-sdk-core'
require 'aws_hosted_zone'

class AwsHostedZoneTests < Minitest::Test

  def test_contructor_not_set
    assert_raises(ArgumentError) { AwsHostedZone.new() }
  end

  def setup
      zones_call = {}
      zones_call[:method] = :list_hosted_zones
      zones_call[:data] = { 
                            hosted_zones: [
                              {
                                name: "carry_up_the_kyber.films.com", 
                                id: "carry2", 
                                caller_reference: "reference"
                              },
                              {
                                name: "carry_cleo.com", 
                                id: "carry1", 
                                caller_reference: "reference"
                              }
                            ], 
                            marker: "nil", 
                            is_truncated: false, 
                            next_marker: "nil", 
                            max_items: 100
                        }
      zones_call[:client] = Aws::Route53::Client

      zone_call = {}
      zone_call[:method] = :get_hosted_zone
      zone_call[:data] = {
                          hosted_zone: {
                            id: "carry1", 
                            name: "carry_cleo.com", 
                            caller_reference: "terraform-20190612141351623900000001", 
                            config: {
                              comment: "created by TF", 
                              private_zone: false
                            }, 
                            resource_record_set_count: 2, 
                            linked_service: {}
                          }, 
                          delegation_set: {
                            id: "not", 
                            caller_reference: "nil", 
                            name_servers: [
                              "ns-1.awsdns-1.co.uk", 
                              "ns-2.awsdns-2.com", 
                              "ns-3.awsdns-3.net"]
                          }, 
                          vp_cs: []
                        }
      zone_call[:client] = Aws::Route53::Client

      record_call = {}
      record_call[:method] = :list_resource_record_sets
      record_call[:data] = {
        resource_record_sets: [
          {
            name: "sid-james.carry-on.films.com", 
            type: "A", 
            ttl: 172800, 
            resource_records: [
              {
                value: "10.10.10.10"
              }
              ], 
            },
            {
              name: "barbara-windsor.carry-on.films.com", 
              type: "A", 
              ttl: 900, 
              resource_records: [
                {
                  value: "10.10.10.11"
                }
              ], 
            }
          ], 
          is_truncated: false, 
          max_items: 100
        }
      record_call[:client] = Aws::Route53::Client

      @zone = AwsHostedZone.new(zone_name: "carry_cleo.com", client_args: { stub_responses: true }, stub_data: [zones_call, zone_call, record_call])
  end

  def test_ns_count 
    assert_equal(@zone.name_servers.count, 3)
  end

  def test_private_zone
    refute @zone.private_zone
  end

  def test_it_exists
    assert @zone.exist?
  end

  def test_record_count
    assert_equal(@zone.record_count, 2)

  end

  def test_record_exists
    assert @zone.record_names.include?("sid-james.carry-on.films.com")
  end

  def test_record_does_not_exists
    refute @zone.record_names.include?("roy-castle.carry-on.films.com")
  end

end