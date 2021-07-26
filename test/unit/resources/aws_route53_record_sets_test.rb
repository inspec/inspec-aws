require 'helper'
require 'aws_route53_record_sets'
require 'aws-sdk-core'

class AWSRoute53RecordSetsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53RecordSets.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53RecordSets.new(hosted_zone_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53RecordSets.new(unexpected: 9) }
  end
end

class AWSRoute53RecordSetsSuccessPathTest < Minitest::Test

  def setup
    record_call = {}
    record_call[:method] = :list_resource_record_sets
    record_call[:data] = {
      resource_record_sets: [
        {
          name: "test1",
          type: "test1",
          set_identifier: "test1",
          weight: 1,
          region: "test1",
          failover: "test1",
          multi_value_answer: true,
          ttl: 1,
          resource_records: [
            {
              value: "10.10.10.10"
            }
          ],
          health_check_id: "test1",
          traffic_policy_instance_id: "test1",
        }
      ],
      is_truncated: false,
      max_items: 100
    }
    record_call[:client] = Aws::Route53::Client
    @resource_record_sets = AWSRoute53RecordSets.new(hosted_zone_id: 'test1', client_args: { stub_responses: true }, stub_data: [record_call])
  end

  def test_record_set_exists
    assert @resource_record_sets.exist?
  end

  def test_names
    assert_equal(@resource_record_sets.names, ['test1'])
  end

  def test_types
    assert_equal(@resource_record_sets.types, ['test1'])
  end

  def test_set_identifiers
    assert_equal(@resource_record_sets.set_identifiers, ['test1'])
  end

  def test_weights
    assert_equal(@resource_record_sets.weights, [1])
  end

  def test_regions
    assert_equal(@resource_record_sets.regions, ['test1'])
  end

  def test_failovers
    assert_equal(@resource_record_sets.failovers, ['test1'])
  end

  def test_multi_value_answers
    assert_equal(@resource_record_sets.multi_value_answers, [true])
  end

  def test_ttls
    assert_equal(@resource_record_sets.ttls, [1])
  end

  def test_health_check_ids
    assert_equal(@resource_record_sets.health_check_ids, ['test1'])
  end

  def test_traffic_policy_instance_ids
    assert_equal(@resource_record_sets.traffic_policy_instance_ids, ['test1'])
  end
end