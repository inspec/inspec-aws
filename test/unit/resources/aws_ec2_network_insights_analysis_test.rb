require 'helper'
require 'aws_ec2_network_insights_analysis'
require 'aws-sdk-core'

class AWSEC2NetworkInsightsAnalysisConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsAnalysis.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsAnalysis.new(network_insights_analysis_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsAnalysis.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInsightsAnalysisSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_insights_analyses
    mock_data = {}
    mock_data[:network_insights_analysis_id] = 'test1'
    mock_data[:network_insights_analysis_arn] = 'test1'
    mock_data[:network_insights_path_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    data[:data] = { network_insights_analyses: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInsightsAnalysis.new(network_insights_analysis_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_insights_analyses_exists
    assert @resp.exists?
  end

  def test_network_insights_analysis_id
    assert_equal(@resp.network_insights_analysis_id, 'test1')
  end

  def test_network_insights_analysis_arn
    assert_equal(@resp.network_insights_analysis_arn, 'test1')
  end

  def test_network_insights_path_id
    assert_equal(@resp.network_insights_path_id, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_status_message
    assert_equal(@resp.status_message, 'test1')
  end
end