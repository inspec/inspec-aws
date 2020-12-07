require 'aws-sdk-core'
require 'aws_eks_cluster'
require 'helper'
require_relative 'mock/iam/aws_eks_cluster_mock'

class AwsEksClusterConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEksCluster.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_cluster_name
    AwsEksCluster.new(cluster_name: 'rooty-tooty-cluster', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEksCluster.new(rubbish: 9) }
  end

  def test_cluster_not_existing
    refute AwsEksCluster.new(cluster_name: 'rooty-tooty-cluster', client_args: { stub_responses: true }).exists?
  end
end

class AwsEksClusterTest < Minitest::Test

  def setup
    # Given
    @mock = AwsEksClusterMock.new
    @mock_eks = @mock.eks

    # When
    @eks = AwsEksCluster.new(cluster_name: 'rooty-tooty-cluster',
                            client_args: { stub_responses: true },
                            stub_data: @mock.stub_data)
  end

  def test_exists
    assert @eks.exists?
  end

  def test_eks_arn
    assert_equal(@eks.arn, @mock_eks[:cluster][:arn])
  end

  def test_eks_name
    assert_equal(@eks.name, @mock_eks[:cluster][:name])
  end

  def test_eks_version
    assert_equal(@eks.version, @mock_eks[:cluster][:version])
  end

  def test_eks_status
    assert_equal(@eks.status, @mock_eks[:cluster][:status])
  end

  def test_eks_endpoint
    assert_equal(@eks.endpoint, @mock_eks[:cluster][:endpoint])
  end

  def test_eks_role_arn
    assert_equal(@eks.role_arn, @mock_eks[:cluster][:role_arn])
  end

  def test_eks_subnet_ids
    assert_equal(@eks.subnet_ids, @mock_eks[:cluster][:resources_vpc_config][:subnet_ids])
  end

  def test_eks_subnet_count
    assert_equal(@eks.subnets_count, @mock_eks[:cluster][:resources_vpc_config][:subnet_ids].length)
  end

  def test_eks_security_group_ids
    assert_equal(@eks.security_group_ids, @mock_eks[:cluster][:resources_vpc_config][:security_group_ids])
  end

  def test_eks_security_group_count
    assert_equal(@eks.security_groups_count, @mock_eks[:cluster][:resources_vpc_config][:security_group_ids].length)
  end

  def test_eks_creating
    assert @eks.creating
  end

  def test_eks_deleting
    assert !@eks.deleting
  end

  def test_eks_tags
    assert_equal(@eks.tags, @mock_eks[:cluster][:tags])
  end

  def test_eks_enabled_logging_types
    assert_equal(@eks.enabled_logging_types, @mock_eks[:cluster].dig(:logging, :cluster_logging).select{|z| z[:enabled] == true }.map {|x| x[:types] }.flatten)
  end

  def test_eks_disabled_logging_types
    assert_equal(@eks.disabled_logging_types, @mock_eks[:cluster].dig(:logging, :cluster_logging).select{|z| z[:enabled] == false }.map {|x| x[:types] }.flatten)
  end
end
