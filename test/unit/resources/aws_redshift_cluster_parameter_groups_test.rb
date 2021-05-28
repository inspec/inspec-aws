require 'helper'
require 'aws_redshift_cluster_parameter_groups'
require 'aws-sdk-core'

class AwsRedshiftClusterParameterGroupsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsRedshiftClusterParameterGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRedshiftClusterParameterGroups.new('rubbish') }
  end

  def test_vpcs_non_existing_for_empty_response
    refute AwsRedshiftClusterParameterGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRedshiftClusterParameterGroupsPathTest < Minitest::Test

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
    @parameter_groups = AwsRedshiftClusterParameterGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_name_exists
    assert @parameter_groups.exists?
  end

  def test_parameter_group_name_available
    assert @parameter_groups.available?
  end

  def test_parameter_group_names
    assert_equal(@parameter_groups.parameter_group_names, ['test1'])
  end

  def test_parameter_group_families
    assert_equal(@parameter_groups.parameter_group_families, ['test1'])
  end

  def test_descriptions
    assert_equal(@parameter_groups.descriptions, ['test1'])
  end
end