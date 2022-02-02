
require 'helper'
require 'aws-sdk-core'
require 'aws_eks_clusters'
require_relative 'mock/iam/aws_eks_cluster_mock'

class AwsEksClustersConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsEksClusters.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEksClusters.new('rubbish') }
  end

  def test_eks_clusters_non_existing_for_empty_response
    refute AwsEksClusters.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEksClustersTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :list_clusters
    data[:data] = { clusters: ['mock1'] }
    data[:client] = Aws::EKS::Client
    data2 = {}
    @mock = AwsEksClusterMock.new
    data2[:method] = :describe_cluster
    data2[:data] = @mock.eks
    data2[:client] = Aws::EKS::Client
    @eks = AwsEksClusters.new(client_args: { stub_responses: true }, stub_data: [data, data2, data2])
  end

  def test_exists
    assert @eks.exist?
  end

  def test_eks_count
    assert_equal(@eks.names.count, 1)
    assert_equal(@eks.arns.count, 1)
  end

  def test_eks_filtering_not_there
    refute @eks.where(name: 'bad').exist?
    refute @eks.where(version: 'bad').exist?
  end

  def test_eks_filtering_there
    assert @eks.where(version: '1.11').exist?
    assert @eks.where(name: 'mock-cluster').exist?
  end
end
