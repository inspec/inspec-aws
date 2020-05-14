require 'helper'
require 'aws_ec2_instances'
require 'aws-sdk-core'

class AwsEc2InstancesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEc2Instances.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEc2Instances.new('rubbish') }
  end

  def test_instances_non_existing_for_empty_response
    refute AwsEc2Instances.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2InstancesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_type] = 't3.micro'
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:subnet_id] = 'subnet-9fe303e5'
    mock_ec2[:vpc_id] = 'vpc-1ea06476'
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    @instances = AwsEc2Instances.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instances_exists
    assert @instances.exist?
  end

  def test_instances_ids
    assert_equal(@instances.instance_ids, ['i-00b5186ddefdb50bf'])
  end

  def test_instances_vpc_ids
    assert_equal(@instances.vpc_ids, ['vpc-1ea06476'])
  end

  def test_instances_subnet_ids
    assert_equal(@instances.subnet_ids, ['subnet-9fe303e5'])
  end

  def test_instances_types
    assert_equal(@instances.instance_types, ['t3.micro'])
  end

  def test_instances_filtering_not_there
    refute @instances.where(:instance_id => 'bad').exist?
  end

  def test_instances_filtering_there
    assert @instances.where(:instance_id => 'i-00b5186ddefdb50bf').exist?
  end
end

class AwsEc2InstancesMultipleTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_type] = 't3.micro'
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:subnet_id] = 'subnet-9fe303e5'
    mock_ec2[:vpc_id] = 'vpc-1ea06476'
    mock_ec2[:tags] = [{ :key => "Name", :value => "aws-inspec-linux-ubuntu-vm" }]
    another_ec2 = {}
    another_ec2[:instance_type] = 't3.micro'
    another_ec2[:instance_id] = 'i-00b5186ddefdb50bg'
    another_ec2[:subnet_id] = 'subnet-9fe303e5'
    another_ec2[:vpc_id] = 'vpc-1ea06476'
    another_ec2[:iam_instance_profile] = {
        arn: "arn:aws:iam::510367013858:instance-profile/InSpecInstanceProfile",
        id: "AIPAXNVB6TPRCNUXFZ2OT",
    }
    data[:data] = { :reservations => [{ :instances => [mock_ec2, another_ec2] }] }
    data[:client] = Aws::EC2::Client
    @instances = AwsEc2Instances.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instances_exists
    assert @instances.exist?
  end

  def test_instances_ids
    assert_equal(@instances.instance_ids, ['i-00b5186ddefdb50bf', 'i-00b5186ddefdb50bg'])
  end

  def test_instances_count
    assert_equal(@instances.count, 2)
  end

  def test_tags
    assert_includes(@instances.tags,{"Name" => "aws-inspec-linux-ubuntu-vm"})
  end

  def test_iam_profiles
    assert_includes(@instances.iam_profiles, "InSpecInstanceProfile")
  end
end