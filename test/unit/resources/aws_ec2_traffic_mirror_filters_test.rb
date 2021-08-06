require 'helper'
require 'aws_ec2_traffic_mirror_filters'
require 'aws-sdk-core'

class AWSEc2TrafficMirrorFiltersTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilters.new(rubbish: 9,client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilters.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilters.new(rubbish: 9) }
  end

  def test_rejects_invalid_launch_template_endpoint_id
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilters.new(launch_template_id1: 'test') }
  end
end

class AWSEc2TrafficMirrorFiltersPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_traffic_mirror_filters
    mock_lt = {}
    mock_lt[:traffic_mirror_filter_id] = 'tmf-01a6e9ac9f962f154'
    mock_lt[:description] = 'test-description'
    data[:data] = { :traffic_mirror_filters => [mock_lt] }
    data[:client] = Aws::EC2::Client
    @addr = AWSEc2TrafficMirrorFilters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_traffic_mirrior_filter_exists
    assert @addr.exists?
  end

  def test_traffic_mirrior_filter_id
    assert_equal(@addr.traffic_mirror_filter_ids, ["tmf-01a6e9ac9f962f154"])
  end

  def test_traffic_mirrior_filter_description
    assert_equal(@addr.descriptions, ["test-description"])
  end
end
