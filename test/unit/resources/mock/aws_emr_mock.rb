require_relative 'aws_base_resource_mock'

class AwsEmrMock < AwsBaseResourceMock
  attr_accessor :cluster_id, :cluster_state, :cluster_arn

  def initialize
    super

    @mock_cluster = {
      id: 'j-27SM4YJB3YVPL',
      status: { state: 'RUNNING' },
      cluster_arn: 'cluster-arn',
    }
  end

  def mock_cluster(cluster_id = 'j-27SM4YJB3YVPL', cluster_state = 'RUNNING', cluster_arn = 'cluster-arn')
    @mock_cluster = {
      id: cluster_id,
      status: {
        state: cluster_state,
        state_change_reason: {
          code: 'USER_REQUEST',
          message: 'This is test message',
        },
      },
      cluster_arn: cluster_arn,
      applications: [
        {
          name: 'Spark',
          version: '3.1.2',
        },
      ],
      security_configuration: 'my-test-security-configuration',
    }
  end

  def create_simple_mock_cluster(cluster_id = 'j-27SM4YJB3YVPL', cluster_state = 'RUNNING', cluster_arn = 'cluster-arn')
    @mock_cluster = {
      id: cluster_id,
      status: {
        state: cluster_state,
        state_change_reason: {
          code: 'USER_REQUEST',
          message: 'This is test message',
        },
      },
      cluster_arn: cluster_arn,
    }
  end

  def create_mock_cluster_list
    mock_clusters = []
    mock_cluster1 = AwsEmrMock.new.create_simple_mock_cluster
    mock_clusters << mock_cluster1
    mock_cluster2 = AwsEmrMock.new.create_simple_mock_cluster('j-27SM4ABCDEF', 'RUNNING', 'mycluster-arn')
    mock_clusters << mock_cluster2
    mock_clusters
  end

  def stub_data_mock_cluster
    describe_cluster = {
      client: Aws::EMR::Client,
      method: 'describe_cluster',
      data: { cluster: mock_cluster },
    }
    [describe_cluster]
  end

  def stub_data_mock_clusters
    list_cluster = {
      client: Aws::EMR::Client,
      method: 'list_clusters',
      data: { clusters: create_mock_cluster_list },
    }
    describe_cluster = {
      client: Aws::EMR::Client,
      method: 'describe_cluster',
      data: { cluster: mock_cluster },
    }
    [list_cluster, describe_cluster]
  end

  def stub_data(stub_type)
    stub_data = []
    describe_cluster = {
      client: Aws::EMR::Client,
      method: 'describe_cluster',
      data: { cluster: mock_cluster },
    }
    list_cluster = {
      client: Aws::EMR::Client,
      method: 'list_clusters',
      data: { clusters: create_mock_cluster_list },
    }
    case stub_type
    when StubDataType::SINGULAR
      stub_data += [describe_cluster]
    when StubDataType::PLURAL
      stub_data += [describe_cluster]
      stub_data += [list_cluster]
    end
    stub_data
  end
end

module StubDataType
  SINGULAR = 0
  PLURAL = 1
end
