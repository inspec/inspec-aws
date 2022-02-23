require 'helper'
require 'aws_rds_global_clusters'
require 'aws-sdk-core'

class AWSRDSGlobalClustersConstructorTest < Minitest::Test

  def test_non_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSGlobalClusters.new('test', client_args: { stub_responses: true }) }
  end

  def test_rejects_params
    assert_raises(ArgumentError) { AWSRDSGlobalClusters.new(unexpected: 9) }
  end
end

class AWSRDSGlobalClustersSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_global_clusters
    mock_data = {}
    mock_data[:global_cluster_identifier] = 'test1'
    mock_data[:global_cluster_resource_id] = 'test1'
    mock_data[:global_cluster_arn] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:engine] = 'test1'
    data[:data] = { global_clusters: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSGlobalClusters.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_global_cluster_exist
    assert @resp.exists?
  end

  def test_global_cluster_identifier_names
    assert_equal(@resp.global_cluster_identifiers, ['test1'])
  end

  def test_global_cluster_resource_ids
    assert_equal(@resp.global_cluster_resource_ids, ['test1'])
  end

  def test_global_cluster_arns
    assert_equal(@resp.global_cluster_arns, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end
end