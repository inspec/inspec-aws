require 'helper'
require 'aws_ecs_cluster'
require 'aws-sdk-core'

class AwsEcsClusterConstructorTest < Minitest::Test

  def setup
    @mock_cluster = {}
    @mock_cluster[:status] = 'ACTIVE'
    @mock_cluster[:statistics] = []
    @mock_cluster[:cluster_arn] = 'an-arn'
    @mock_cluster[:cluster_name] = 'rooty-tooty-pointy-shooty'
    @mock_cluster[:running_tasks_count] = 0
    @mock_cluster[:pending_tasks_count] = 0
    @mock_cluster[:active_services_count] = 0
    @mock_cluster[:registered_container_instances_count] = 0

    stub_data = {}
    stub_data[:method] = :describe_clusters
    stub_data[:data]   = { :clusters => [@mock_cluster] }
    stub_data[:client] = Aws::ECS::Client

    @cluster = AwsEcsCluster.new(cluster_name: @mock_cluster[:cluster_name],
                                 client_args: { stub_responses: true },
                                 stub_data: [stub_data])
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcsCluster.new(client_args: { stub_responses: true }) }
  end

  def test_cluster_name
    assert_equal(@cluster.cluster_name, @mock_cluster[:cluster_name])
  end

  def test_statistics
    assert_equal(@cluster.statistics, @mock_cluster[:statistics])
  end

  def test_arn
    assert_equal(@cluster.cluster_arn, @mock_cluster[:cluster_arn])
  end

  def test_running_task_count
    assert_equal(@cluster.running_tasks_count, @mock_cluster[:running_tasks_count])
  end

  def test_pending_task_count
    assert_equal(@cluster.pending_tasks_count, @mock_cluster[:pending_tasks_count])
  end

  def test_active_services_count
    assert_equal(@cluster.active_services_count, @mock_cluster[:active_services_count])
  end

  def test_registered_container_instances_count
    assert_equal(@cluster.registered_container_instances_count, @mock_cluster[:registered_container_instances_count])
  end

  def test_status
    assert_equal(@cluster.status, @mock_cluster[:status])
  end

  def test_exists
    assert @cluster.exists?
  end

end