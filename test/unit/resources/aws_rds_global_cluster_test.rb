require 'helper'
require 'aws_rds_global_cluster'
require 'aws-sdk-core'

class AWSRDSGlobalClusterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSGlobalCluster.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSGlobalCluster.new(global_cluster_identifier: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSGlobalCluster.new(unexpected: 9) }
  end
end

class AWSRDSGlobalClusterSuccessPathTest < Minitest::Test

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
    @resp = AWSRDSGlobalCluster.new( global_cluster_identifier: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_global_cluster_exist
    assert @resp.exists?
  end

  def test_global_cluster_identifier_name
    assert_equal(@resp.global_cluster_identifier, 'test1')
  end

  def test_global_cluster_resource_id
    assert_equal(@resp.global_cluster_resource_id, 'test1')
  end

  def test_global_cluster_arn
    assert_equal(@resp.global_cluster_arn, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end
end