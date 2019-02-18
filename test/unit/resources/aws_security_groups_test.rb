require 'helper'
require 'aws_security_groups'
require 'aws-sdk-core'

class AwsSecurityGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSecurityGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSecurityGroups.new('rubbish') }
  end

  def test_security_groups_non_existing_for_empty_response
    refute AwsSecurityGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSecurityGroupsTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group_one = {}
    security_group_one[:description] = 'security group alpha with no rules'
    security_group_one[:group_name] = 'group alpha'
    security_group_one[:group_id] = 'sg-abcd1234'
    security_group_one[:ip_permissions] = []
    security_group_one[:ip_permissions_egress] = []
    security_group_one[:vpc_id] = 'vpc-abcd1234'
    security_group_two = {}
    security_group_two[:description] = 'security group beta with no rules'
    security_group_two[:group_name] = 'group beta'
    security_group_two[:group_id] = 'sg-1234abcd'
    security_group_two[:ip_permissions] = []
    security_group_two[:ip_permissions_egress] = []
    security_group_two[:vpc_id] = 'vpc-1234abcd'
    data[:data] = { :security_groups => [security_group_one, security_group_two] }
    data[:client] = Aws::EC2::Client
    @security_groups = AwsSecurityGroups.new(client_args: { stub_responses: true }, stub_data: [data])

  end

  def test_security_groups_exists
    assert @security_groups.exist?
  end

  def test_security_groups_ids
    assert_equal(@security_groups.group_ids, ['sg-abcd1234', 'sg-1234abcd'])
  end

  def test_security_groups_vpc_ids
    assert_equal(@security_groups.vpc_ids, ['vpc-abcd1234', 'vpc-1234abcd'])
  end

  def test_security_groups_names
    assert_equal(@security_groups.group_names, ['group alpha', 'group beta'])
  end

  def test_security_groups_filtering_not_there_vpc
    refute @security_groups.where(:vpc_id => 'bad').exist?
  end

  def test_security_groups_filtering_there_vpc
    assert @security_groups.where(:vpc_id => 'vpc-abcd1234').exist?
  end

  def test_security_groups_filtering_not_there_name
    refute @security_groups.where(:group_id => 'bad').exist?
  end

  def test_security_groups_filtering_there_name
    assert @security_groups.where(:group_id => 'sg-1234abcd').exist?
  end

  def test_security_groups_filtering_not_there_id
    refute @security_groups.where(:group_name => 'bad').exist?
  end

  def test_security_groups_filtering_there_id
    assert @security_groups.where(:group_name => 'group beta').exist?
  end
end