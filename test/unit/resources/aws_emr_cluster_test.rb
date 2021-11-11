require 'helper'
require 'aws_emr_cluster'
require 'aws-sdk-core'
require_relative 'mock/aws_emr_mock'

class AwsEmrClusterConstructorTest < Minitest::Test
  def setup
    @stub_data = AwsEmrMock.new.stub_data_mock_cluster
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: @stub_data)
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEmrCluster.new(client_args: { stub_responses: true }) }
  end

  def test_cluster_id
    assert_equal(@cluster.cluster_id, @stub_data[0][:data][:cluster][:id])
  end

  def test_arn
    assert_equal(@cluster.cluster_arn, @stub_data[0][:data][:cluster][:cluster_arn])
  end

  def test_state
    assert_equal(@cluster.state, @stub_data[0][:data][:cluster][:status][:state])
  end

  def test_exists
    assert @cluster.exists?
  end
end

class AwsEmrClusterAtRestEncryptionEnabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrMock.new.stub_data(StubDataType::AT_REST_ENCRYPTION_ENABLED))
  end

  def test_encryption_at_rest_enabled
    assert_equal(@cluster.encryption_at_rest, true)
  end
end

class AwsEmrClusterAtRestEncryptionDisabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrMock.new.stub_data(StubDataType::AT_REST_ENCRYPTION_DISBALED))
  end

  def test_encryption_at_rest_disabled
    assert_equal(@cluster.encryption_at_rest, false)
  end
end

class AwsEmrClusterInTransitEncryptionEnabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrMock.new.stub_data(StubDataType::IN_TRANSIT_ENCRYPTION_ENABLED))
  end

  def test_encryption_in_transit_enabled
    assert_equal(@cluster.encryption_in_transit, true)
  end
end

class AwsEmrClusterInTransitEncryptionDisabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrMock.new.stub_data(StubDataType::IN_TRANSIT_ENCRYPTION_DISABLED))
  end

  def test_encryption_in_transit_disabled
    assert_equal(@cluster.encryption_in_transit, false)
  end
end

class AwsEmrClusterLocalDiskEncryptionEnabledPathTest < Minitest::Test
  def setup
    @cluster = AwsEmrCluster.new(cluster_id: 'j-27SM4YJB3YVPL',
                                 client_args: { stub_responses: true },
                                 stub_data: AwsEmrMock.new.stub_data(StubDataType::LOCAL_DISK_ENCRYPTION_ENABLED))
  end

  def test_encryption_local_disk_enabled
    assert_equal(@cluster.local_disk_encryption, true)
  end
end
