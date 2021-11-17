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

  def test_rejects_invalid_traffic_mirror_filter_id
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilters.new(launch_template_id1: 'test') }
  end
end

class AWSEc2TrafficMirrorFiltersPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_traffic_mirror_filters
    mock_data = {}
    mock_data[:traffic_mirror_filter_id] = 'tmf-01a6e9ac9f962f154'
    mock_data[:description] = 'test-description'
    data[:data] = { :traffic_mirror_filters => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEc2TrafficMirrorFilters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_traffic_mirrior_filter_exists
    assert @resp.exists?
  end

  def test_traffic_mirrior_filter_ids
    assert_equal(@resp.traffic_mirror_filter_ids, ["tmf-01a6e9ac9f962f154"])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ["test-description"])
  end
end
