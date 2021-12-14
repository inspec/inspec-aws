require 'helper'
require 'aws_hosted_zones'
require 'aws-sdk-core'

class AWSHostedZonesConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSHostedZones.new(unexpected: 9) }
  end
end

class AWSHostedZonesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_hosted_zones
    mock_data = {}
    mock_data[:marker] = 'test1'
    mock_data[:is_truncated] = true
    mock_data[:max_items] = 1
    mock_data[:hosted_zones] = [
      id: 'test1',
      name: 'test1',
      caller_reference: 'test1',
      config: {},
      resource_record_set_count: 10,
      linked_service: {},
    ]
    data[:data] = mock_data
    data[:client] = Aws::Route53::Client
    @resp = AWSHostedZones.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_hosted_zones_exist
    assert @resp.exists?
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_caller_references
    assert_equal(@resp.caller_references, ['test1'])
  end

  def test_configs
    assert_equal(@resp.configs, [{}])
  end

  def test_resource_record_set_counts
    assert_equal(@resp.resource_record_set_counts, [10])
  end

  def test_linked_services
    assert_equal(@resp.linked_services, [{}])
  end
end
