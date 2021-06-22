# require 'helper'
# require 'aws_route53_record_set'
# require 'aws-sdk-core'
#
# class AWSRoute53RecordSetConstructorTest < Minitest::Test
#
#   def test_empty_params_not_ok
#     assert_raises(ArgumentError) { AWSRoute53RecordSet.new(client_args: { stub_responses: true }) }
#   end
#
#   def test_empty_param_arg_not_ok
#     assert_raises(ArgumentError) { AWSRoute53RecordSet.new(hosted_zone_id: '', start_record_name: '', client_args: { stub_responses: true }) }
#   end
#
#   def test_rejects_unrecognized_params
#     assert_raises(ArgumentError) { AWSRoute53RecordSet.new(unexpected: 9) }
#   end
# end
#
# class AWSRoute53RecordSetSuccessPathTest < Minitest::Test
#
#   def setup
#     data = {}
#     data[:method] = :list_resource_record_sets
#     mock_data = {}
#     # mock_data[:is_truncated] = true
#     # mock_data[:max_items] = 1
#     # mock_data[:name] = 'test1'
#     # mock_data[:type] = 'test1'
#     # mock_data[:set_identifier] = 'test1'
#     # mock_data[:weight] = 1
#     # mock_data[:region] = 'test1'
#     # mock_data[:geo_location] = {}
#     # mock_data[:failover] = {}
#     # mock_data[:multi_value_answer] = true
#     # mock_data[:ttl] = 1
#     # mock_data[:resource_records] = []
#     # mock_data[:alias_target] = {}
#     # mock_data[:health_check_id] = 'test1'
#     # mock_data[:traffic_policy_instance_id] = 'test1'
#     # data[:data] = { resource_record_sets: [mock_data] }
#     #
#     mock_data[:data] = {
#       resource_record_sets: [
#         {
#           name: "test1",
#           type: "test1",
#           set_identifier: "test1",
#         }
#       ],
#       is_truncated: false,
#       max_items: 100
#     }
#     data[:client] = Aws::Route53::Client
#     @resource_record_sets = AWSRoute53RecordSet.new(hosted_zone_id: 'test1', start_record_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
#   end
#
#   def test_hosted_zone_exists
#     assert @resource_record_sets.exists?
#   end
#
#   def test_name
#     assert_equal(@resource_record_sets.name, 'test1')
#   end
#
#   def test_type
#     assert_equal(@resource_record_sets.type, 'test1')
#   end
#
#   def test_set_identifier
#     assert_equal(@resource_record_sets.set_identifier, 'test1')
#   end
#
#   def test_weight
#     assert_equal(@resource_record_sets.weight, 1)
#   end
#
#   def test_region
#     assert_equal(@hosted_zone.region, 'test1')
#   end
#
#   # def test_geo_location
#   #   assert_equal(@hosted_zone.geo_location, {})
#   # end
#   #
#   # def test_failover
#   #   assert_equal(@hosted_zone.failover, {})
#   # end
#   #
#   # def test_multi_value_answer
#   #   assert_equal(@hosted_zone.multi_value_answer, true)
#   # end
#   #
#   # def test_ttl
#   #   assert_equal(@resource_record_sets.ttl, 1)
#   # end
# end