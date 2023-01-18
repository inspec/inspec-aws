require 'helper'
require 'aws_rds_option_groups'
require 'aws-sdk-core'

class AwsRdsOptionGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRdsOptionGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsOptionGroups.new('rubbish') }
  end

  def test_instances_non_existing_for_empty_response
    refute AwsRdsOptionGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRdsOptionGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_option_groups
    mock_option_groups = {}
    mock_option_groups[:option_group_name] = 'default:aurora-5-6'
    mock_option_groups[:option_group_description] = 'Default option group for aurora 5.6'
    mock_option_groups[:engine_name] = 'aurora'
    mock_option_groups[:major_engine_version] = '5.6'
    mock_option_groups[:option_group_arn] = 'arn:aws:rds:us-east-2:112758395563:og:default:aurora-5-6'
    mock_option_groups[:allows_vpc_and_non_vpc_instance_memberships] = true
    data[:data] = { :option_groups_list => [mock_option_groups] }
    data[:client] = Aws::RDS::Client
    @option_group = AwsRdsOptionGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instances_exists
    assert @option_group.exist?
  end

  def test_instances_names
    assert_equal(@option_group.option_group_names, ['default:aurora-5-6'])
  end

  def test_instances_filtering_not_there
    @option_group.where(:option_group_name => 'default:aurora-5-6').exist?
  end

  def test_instances_filtering_there
    assert @option_group.where(:option_group_arn => 'arn:aws:rds:us-east-2:112758395563:og:default:aurora-5-6').exist?
  end
end

