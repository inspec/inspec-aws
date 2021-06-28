require 'helper'
require 'aws_route53_record_set'
require 'aws-sdk-core'

class AWSRoute53RecordSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53RecordSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53RecordSet.new(hosted_zone_id: '', start_record_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53RecordSet.new(unexpected: 9) }
  end
end

class AWSRoute53RecordSetSuccessPathTest < Minitest::Test

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
    @resource_record_sets = AWSRoute53RecordSet.new(hosted_zone_id: 'test1', start_record_name: 'test1', client_args: { stub_responses: true }, stub_data: [record_call])
  end

  def test_record_set_exists
    assert @resource_record_sets.exist?
  end

  def test_name
    assert_equal(@resource_record_sets.name, 'test1')
  end

  def test_type
    assert_equal(@resource_record_sets.type, 'test1')
  end

  def test_set_identifier
    assert_equal(@resource_record_sets.set_identifier, 'test1')
  end

  def test_weight
    assert_equal(@resource_record_sets.weight, 1)
  end

  def test_region
    assert_equal(@resource_record_sets.region, 'test1')
  end

  def test_failover
    assert_equal(@resource_record_sets.failover, 'test1')
  end

  def test_multi_value_answer
    assert_equal(@resource_record_sets.multi_value_answer, true)
  end

  def test_ttl
    assert_equal(@resource_record_sets.ttl, 1)
  end

  def test_health_check_id
    assert_equal(@resource_record_sets.health_check_id, 'test1')
  end

  def test_traffic_policy_instance_id
    assert_equal(@resource_record_sets.traffic_policy_instance_id, 'test1')
  end
end