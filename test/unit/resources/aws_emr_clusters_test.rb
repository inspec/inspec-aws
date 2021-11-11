require 'helper'
require 'aws_emr_clusters'
require 'aws-sdk-core'
require_relative 'mock/aws_emr_mock'

class AwsEmrClustersConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsEmrClusters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEmrClusters.new('rubbish') }
  end

  def test_snapshots_non_existing_for_empty_response
    refute AwsEmrClusters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEmrClustersHappyPathTest < Minitest::Test
  def setup
    mock_clusters = []
    mock_cluster1 = AwsEmrMock.new.mock_cluster
    mock_clusters << mock_cluster1
    mock_cluster2 = AwsEmrMock.new.mock_cluster('j-27SM4ABCDEF', 'RUNNING', 'mycluster-arn')
    mock_clusters << mock_cluster2

    data = {}
    data[:method] = :list_clusters
    data[:data] = { clusters: mock_clusters }
    data[:client] = Aws::EMR::Client
    @clusters = AwsEmrClusters.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_clusters_exists
    assert @clusters.exist?
  end

  def test_clusters_running
    assert @clusters.running?
  end
end
