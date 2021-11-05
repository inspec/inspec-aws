require 'helper'
require 'aws_ec2_network_insights_analysis_plural'
require 'aws-sdk-core'

class AWSEC2NetworkInsightsAnalysisPluralConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2NetworkInsightsAnalysisPlural.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2NetworkInsightsAnalysisPlural.new('rubbish') }
  end

  def test_network_insights_analyses_non_existing_for_empty_response
    refute AWSEC2NetworkInsightsAnalysisPlural.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2NetworkInsightsAnalysisPluralHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_insights_analyses
    mock_data = {}
    mock_data[:network_insights_analysis_id] = 'test1'
    mock_data[:network_insights_analysis_arn] = 'test1'
    mock_data[:network_insights_path_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    data[:data] = { :network_insights_analyses => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInsightsAnalysisPlural.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_insights_analysis_ids
    assert_equal(@resp.network_insights_analysis_ids, ['test1'])
  end

  def test_network_insights_analysis_arns
    assert_equal(@resp.network_insights_analysis_arns, ['test1'])
  end

  def test_network_insights_path_ids
    assert_equal(@resp.network_insights_path_ids, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end

  def test_status_messages
    assert_equal(@resp.status_messages, ['test1'])
  end
end