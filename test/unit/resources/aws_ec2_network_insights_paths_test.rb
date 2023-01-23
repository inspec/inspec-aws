require 'helper'
require 'aws_ec2_network_insights_paths'
require 'aws-sdk-core'

class AWSEC2NetworkInsightsPathsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2NetworkInsightsPaths.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsPaths.new('rubbish') }
  end

  def test_network_insights_paths_non_existing_for_empty_response
    refute AWSEC2NetworkInsightsPaths.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2NetworkInsightsPathsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_insights_paths
    mock_data = {}
    mock_data[:network_insights_path_id] = 'test1'
    mock_data[:network_insights_path_arn] = 'test1'
    mock_data[:source] = 'test1'
    mock_data[:destination] = 'test1'
    mock_data[:source_ip] = 'test1'
    mock_data[:destination_ip] = 'test1'
    mock_data[:protocol] = 'test1'
    mock_data[:destination_port] = 22
    data[:data] = { :network_insights_paths => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInsightsPaths.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_insights_path_ids
    assert_equal(@resp.network_insights_path_ids, ['test1'])
  end

  def test_network_insights_path_arns
    assert_equal(@resp.network_insights_path_arns, ['test1'])
  end

  def test_source
    assert_equal(@resp.sources, ['test1'])
  end

  def test_destinations
    assert_equal(@resp.destinations, ['test1'])
  end

  def test_source_ips
    assert_equal(@resp.source_ips, ['test1'])
  end

  def test_destination_ips
    assert_equal(@resp.destination_ips, ['test1'])
  end

  def test_protocols
    assert_equal(@resp.protocols, ['test1'])
  end

  def test_destination_ports
    assert_equal(@resp.destination_ports, [22])
  end
end