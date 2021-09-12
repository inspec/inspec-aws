
require 'helper'
require 'aws_ec2_traffic_mirror_filter'
require 'aws-sdk-core'

class AWSEc2TrafficMirrorFilterTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilter.new(rubbish: 9,client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilter.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilter.new(rubbish: 9) }
  end

  def test_rejects_invalid_traffic_mirror_filter
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorFilter.new(traffic_mirror_filter_idt: 'lt-09nf4j4hgj4k4hf4k' ) }
  end
end

class AWSEc2TrafficMirrorFilterPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_traffic_mirror_filters
    mock_data = {}
    mock_data[:traffic_mirror_filter_id] = 'tmf-01a6e9ac9f962f154'
    mock_data[:description] = 'test-description'
    data[:data] = { :traffic_mirror_filters => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEc2TrafficMirrorFilter.new(traffic_mirror_filter_id: 'tmf-01a6e9ac9f962f154', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_traffic_mirrior_filter_exists
    assert @resp.exists?
  end

  def test_traffic_mirrior_filter_id
    assert_equal(@resp.traffic_mirror_filter_id, "tmf-01a6e9ac9f962f154")
  end

  def test_traffic_mirrior_filter_description
    assert_equal(@resp.description, "test-description")
  end
end

