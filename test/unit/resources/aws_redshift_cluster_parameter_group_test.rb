require 'helper'
require 'aws_redshift_cluster_parameter_group'
require 'aws-sdk-core'

class AwsRedshiftClusterParameterGroupConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRedshiftClusterParameterGroup.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_vpc_endpoint_id_as_hash_eight_sign
    AwsRedshiftClusterParameterGroup.new(parameter_group_name: 'test1', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_endpoint_id_as_hash
    AwsRedshiftClusterParameterGroup.new(parameter_group_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRedshiftClusterParameterGroup.new(rubbish: 9) }
  end
end

class AwsRedshiftClusterParameterGroupPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_cluster_parameter_groups
    mock_parameter_groups = {}
    mock_parameter_groups[:parameter_group_name] = 'test1'
    mock_parameter_groups[:parameter_group_family] = 'test1'
    mock_parameter_groups[:description] = 'test1'
    mock_parameter_groups[:tags] = []
    data[:data] = { :parameter_groups => [mock_parameter_groups] }
    data[:client] = Aws::Redshift::Client
    @parameter_groups = AwsRedshiftClusterParameterGroup.new(parameter_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_name_exists
    assert @parameter_groups.exists?
  end

  def test_parameter_group_name_available
    assert @parameter_groups.available?
  end

  def test_parameter_group_name
    assert_equal(@parameter_groups.parameter_group_name, 'test1')
  end

  def test_parameter_group_family
    assert_equal(@parameter_groups.parameter_group_family, 'test1')
  end

  def test_description
    assert_equal(@parameter_groups.description, 'test1')
  end
end