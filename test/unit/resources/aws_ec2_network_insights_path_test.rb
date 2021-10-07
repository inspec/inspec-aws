require 'helper'
require 'aws_ec2_network_insights_path'
require 'aws-sdk-core'

class AWSEC2NetworkInsightsPathConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsPath.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsPath.new(internet_gateway_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsPath.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInsightsPathSuccessPathTest < Minitest::Test

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
    data[:data] = { network_insights_paths: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInsightsPath.new(network_insights_path_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_insights_paths_exists
    assert @resp.exists?
  end

  def test_network_insights_path_id
    assert_equal(@resp.network_insights_path_id, 'test1')
  end

  def test_network_insights_path_arn
    assert_equal(@resp.network_insights_path_arn, 'test1')
  end

  def test_source
    assert_equal(@resp.source, 'test1')
  end

  def test_destination
    assert_equal(@resp.destination, 'test1')
  end

  def test_source_ip
    assert_equal(@resp.source_ip, 'test1')
  end

  def test_destination_ip
    assert_equal(@resp.destination_ip, 'test1')
  end

  def test_protocol
    assert_equal(@resp.protocol, 'test1')
  end

  def test_destination_port
    assert_equal(@resp.destination_port, 22)
  end
end