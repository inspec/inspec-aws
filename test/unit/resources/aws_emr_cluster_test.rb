require 'helper'
require 'aws_emr_cluster'
require 'aws-sdk-core'
require_relative 'mock/aws_emr_mock'

class AwsEmrClusterConstructorTest < Minitest::Test
  def setup
    @stub_data = AwsEmrMock.new.stub_data(StubDataType::SINGULAR)
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
    assert_equal(@stub_data[0][:data][:cluster][:status][:state], @cluster.status_state)
  end

  def test_state_change_reason_code
    assert_equal(@stub_data[0][:data][:cluster][:status][:state_change_reason][:code], @cluster.status_state_change_reason_code)
  end

  def test_state_change_reason_message
    assert_equal(@stub_data[0][:data][:cluster][:status][:state_change_reason][:message], @cluster.status_state_change_reason_message)
  end

  def test_applications_name
    assert_equal(@stub_data[0][:data][:cluster][:applications][0][:name], @cluster.application_names[0])
  end

  def test_security_configuration_name
    assert_equal(@stub_data[0][:data][:cluster][:security_configuration], @cluster.security_configuration_name)
  end

  def test_exists
    assert @cluster.exists?
  end

  def test_resource_id
    refute_nil(@cluster.resource_id)
    assert_equal(@cluster.resource_id, @stub_data[0][:data][:cluster][:id])
  end
end
