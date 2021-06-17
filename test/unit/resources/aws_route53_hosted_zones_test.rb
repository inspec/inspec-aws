require 'helper'
require 'aws_route53_hosted_zones'
require 'aws-sdk-core'

class AWSRoute53HostedZonesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSRoute53HostedZones.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSRoute53HostedZones.new('rubbish') }
  end

  def test_hosted_zones_non_existing_for_empty_response
    refute AWSRoute53HostedZones.new(client_args: { stub_responses: true }).exist?
  end
end

# class AWSRoute53HostedZonesHappyPathTest < Minitest::Test
#
#   def setup
#     data = {}
#     data[:method] = :list_hosted_zones
#     mock_data = {}
#     mock_data[:id] = 'test1'
#     mock_data[:name] = 'test1'
#     mock_data[:caller_reference] = 'test1'
#     mock_data[:config] = {}
#     mock_data[:resource_record_set_count] = 1
#     mock_data[:linked_service] = {}
#     data[:data] = { :hosted_zones => [mock_data] }
#     data[:client] = Aws::Route53::Client
#     @hosted_zones = AWSRoute53HostedZones.new(
#       marker: 'PageMarker',
#       max_items: 1,
#       is_truncated: true,
#       client_args: { stub_responses: true },
#       stub_data: [data])
#   end
#
#   def test_hosted_zones_exists
#     assert @hosted_zones.exist?
#   end
#
#   def test_ids
#     assert_equal(@hosted_zones.ids, ['test1'])
#   end
#
#   def test_names
#     assert_equal(@hosted_zones.names, ['test1'])
#   end
#
#   def test_caller_references
#     assert_equal(@hosted_zones.caller_references, ['test1'])
#   end
#
#   def test_configs
#     assert_equal(@hosted_zones.configs, [{}])
#   end
#
#   def test_resource_record_set_counts
#     assert_equal(@hosted_zones.resource_record_set_counts, [1])
#   end
#
#   def test_linked_services
#     assert_equal(@hosted_zones.linked_services, [{}])
#   end
# end