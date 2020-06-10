require 'helper'
require 'aws_ec2_instance'
require 'aws-sdk-core'


class AwsEc2InstanceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2Instance.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsEc2Instance.new('rubbish') }
  end

  def test_accepts_ec2_id_as_hash_eight_sign
    AwsEc2Instance.new(instance_id: 'i-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_ec2_id_as_hash
    AwsEc2Instance.new(instance_id: 'i-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2Instance.new(rubbish: 99) }
  end

  def test_rejects_invalid_ec2_id
    assert_raises(ArgumentError) { AwsEc2Instance.new(instance_id: 'i-not-allowed') }
  end

  def test_rejects_empty_name
    assert_raises(ArgumentError) { AwsEc2Instance.new(instance_id: '') }
  end

  def test_rejects_empty_id
    assert_raises(ArgumentError) { AwsEc2Instance.new(name: '') }
  end

  def test_rejects_empty_both
    assert_raises(ArgumentError) { AwsEc2Instance.new(name: '', instance_id: '') }
  end

  def test_ec2_non_existing
    refute AwsEc2Instance.new(instance_id: 'i-1234abcd', client_args: { stub_responses: true }).exists?
  end

  def test_ec2_non_existing_name
    refute AwsEc2Instance.new(name: 'not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsEc2InstanceConstructorNameTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:tags] = [{ :key => 'Name', :value => 'aws-inspec-linux-ubuntu-vm' }]
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    @ec2 = AwsEc2Instance.new(name: 'aws-inspec-linux-ubuntu-vm', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ec2_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_ec2_exists
    assert @ec2.exists?
  end
end

class AwsEc2InstanceHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:ami_launch_index] = 0
    mock_ec2[:image_id] = 'ami-024279d2324df257e'
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:instance_type] = 't3.micro'
    mock_ec2[:private_dns_name] = 'ip-172-31-22-166.eu-west-2.compute.internal'
    mock_ec2[:private_ip_address] = '172.31.22.166'
    mock_ec2[:public_dns_name] = 'ec2-18-130-227-47.eu-west-2.compute.amazonaws.com'
    mock_ec2[:public_ip_address] = '18.130.227.47'
    mock_ec2[:state_transition_reason] = ''
    mock_ec2[:subnet_id] = 'subnet-9fe303e5'
    mock_ec2[:vpc_id] = 'vpc-1ea06476'
    mock_ec2[:architecture] = 'x86_64'
    mock_ec2[:client_token] = ''
    mock_ec2[:ebs_optimized] = false
    mock_ec2[:ena_support] = true
    mock_ec2[:hypervisor] = 'xen'
    mock_ec2[:root_device_name] = '/dev/sda1'
    mock_ec2[:root_device_type] = 'ebs'
    mock_ec2[:source_dest_check] = true
    mock_ec2[:virtualization_type] = 'hvm'
    mock_ec2[:security_groups] = [{ :group_name => "default", :group_id => "sg-9bb3b9f3" }]
    mock_ec2[:tags] = [{ :key => "Name", :value => "aws-inspec-linux-ubuntu-vm" }]
    mock_ec2[:placement] = { :availability_zone => "eu-west-2a", :group_name => "", :tenancy => "default" }
    mock_ec2[:state] = { :code => 16, :name => "running" }
    mock_ec2[:block_device_mappings] = [{ :device_name => "/dev/sda1", :ebs => { :delete_on_termination => true, :status => "attached", :volume_id => "vol-0929d4dea5e570576" } }]
    mock_ec2[:network_interfaces] = [{ :association => { :ip_owner_id => "amazon", :public_dns_name => "ec2-18-130-227-47.eu-west-2.compute.amazonaws.com", :public_ip => "18.130.227.47" },
                                       :attachment => { :attachment_id => "eni-attach-0842ca545640c04cf", :delete_on_termination => true, :device_index => 0, :status => "attached" },
                                       :description => "",
                                       :groups => [{ :group_name => "default", :group_id => "sg-9bb3b9f3" }],
                                       :ipv_6_addresses => [],
                                       :mac_address => "06:54:8c:5e:d8:78",
                                       :network_interface_id => "eni-03c43e315306d6945",
                                       :owner_id => "510367013858",
                                       :private_dns_name => "ip-172-31-22-166.eu-west-2.compute.internal",
                                       :private_ip_address => "172.31.22.166",
                                       :private_ip_addresses =>
                                           [{ :association => { :ip_owner_id => "amazon", :public_dns_name => "ec2-18-130-227-47.eu-west-2.compute.amazonaws.com", :public_ip => "18.130.227.47" },
                                              :primary => true,
                                              :private_dns_name => "ip-172-31-22-166.eu-west-2.compute.internal",
                                              :private_ip_address => "172.31.22.166" }],
                                       :source_dest_check => true,
                                       :status => "in-use",
                                       :subnet_id => "subnet-9fe303e5",
                                       :vpc_id => "vpc-1ea06476" }]
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    @ec2 = AwsEc2Instance.new(instance_id: 'i-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ec2_exists
    assert @ec2.exists?
  end

  def test_ec2_state
    assert_equal(@ec2.state, 'running')
  end

  def test_ec2_security_groups
    assert_equal(@ec2.security_groups, [{ :id => "sg-9bb3b9f3", :name => "default" }])
  end

  def test_ec2_security_group_ids
    assert_equal(@ec2.security_group_ids, ["sg-9bb3b9f3"])
  end

  def test_ec2_tags
    assert_equal(@ec2.tags, [{ :key => "Name", :value => "aws-inspec-linux-ubuntu-vm" }])
  end

  def test_ec2_ebs_volumes
    assert_equal(@ec2.ebs_volumes, [{ :id => "vol-0929d4dea5e570576", :name => "/dev/sda1" }])
  end

  def test_ec2_availability_zone
    assert_equal(@ec2.availability_zone, 'eu-west-2a')
  end

  def network_interface_ids
    assert_equal(@ec2.network_interface_ids, ["eni-03c43e315306d6945"])
  end

  def test_ec2_ami_launch_index
    assert_equal(@ec2.ami_launch_index, 0)
  end

  def test_ec2_image_id
    assert_equal(@ec2.image_id, 'ami-024279d2324df257e')
  end

  def test_ec2_instance_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_ec2_instance_type
    assert_equal(@ec2.instance_type, 't3.micro')
  end

  def test_ec2_private_dns_name
    assert_equal(@ec2.private_dns_name, 'ip-172-31-22-166.eu-west-2.compute.internal')
  end

  def test_ec2_private_ip_address
    assert_equal(@ec2.private_ip_address, '172.31.22.166')
  end

  def test_ec2_public_dns_name
    assert_equal(@ec2.public_dns_name, 'ec2-18-130-227-47.eu-west-2.compute.amazonaws.com')
  end

  def test_ec2_public_ip_address
    assert_equal(@ec2.public_ip_address, '18.130.227.47')
  end

  def test_ec2_state_transition_reason
    assert_equal(@ec2.state_transition_reason, '')
  end

  def test_ec2_subnet_id
    assert_equal(@ec2.subnet_id, 'subnet-9fe303e5')
  end

  def test_ec2_vpc_id
    assert_equal(@ec2.vpc_id, 'vpc-1ea06476')
  end

  def test_ec2_architecture
    assert_equal(@ec2.architecture, 'x86_64')
  end

  def test_ec2_client_token
    assert_equal(@ec2.client_token, '')
  end

  def test_ec2_ebs_optimized
    assert_equal(@ec2.ebs_optimized, false)
  end

  def test_ec2_ena_support
    assert_equal(@ec2.ena_support, true)
  end

  def test_ec2_hypervisor
    assert_equal(@ec2.hypervisor, 'xen')
  end

  def test_ec2_root_device_name
    assert_equal(@ec2.root_device_name, '/dev/sda1')
  end

  def test_ec2_root_device_type
    assert_equal(@ec2.root_device_type, 'ebs')
  end

  def test_ec2_source_dest_check
    assert_equal(@ec2.source_dest_check, true)
  end

  def test_ec2_virtualization_type
    assert_equal(@ec2.virtualization_type, 'hvm')
  end

  def test_name
    assert_equal(@ec2.name, "aws-inspec-linux-ubuntu-vm")
  end

  # Testing NullResponse when calling undefined methods
  #
  # Calling a static undefined method on resource should return nil
  def test_undefined_method
    assert_nil(@ec2.fake_method.fake_child)
  end

  # Calling undefined method on AWSResourceProbe should return nil
  # `placement` is a dynamically created AWSResourceProbe type method
  def test_undefined_method_on_aws_resource_probe
    assert_nil(@ec2.placement.fake_method.and_another.and_goes_on)
  end

  # Calling undefined method on an existing property should raise NoMethodError
  # `availability_zone` is a valid property of `placement` method
  def test_undefined_method_on_existing_property
    assert_raises(NoMethodError) { @ec2.placement.availability_zone.fake_method}
  end
end

class AwsEc2InstanceStatusTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:state] = { :code => 99, :name => "stopped" }
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    @ec2 = AwsEc2Instance.new(instance_id: 'i-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ec2_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_is_stopped
    assert @ec2.stopped?
  end
end

class AwsEc2InstanceAnotherStatusTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:state] = { :code => 89, :name => "shutting-down" }
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    @ec2 = AwsEc2Instance.new(instance_id: 'i-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ec2_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_is_shutting_down
    assert @ec2.shutting_down?
  end
end


class AwsEc2InstanceEmptyRolesTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:iam_instance_profile] = { arn: 'arn:aws:iam::336924118301:instance-profile/InSpecInstanceProfile' }
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    iam_data = {}
    iam_data[:method] = :get_instance_profile
    mock_iam = {
        arn: "arn:aws:iam::336924118301:instance-profile/InSpecInstanceProfile",
        create_date: Time.parse("2013-06-12T23:52:02Z"),
        instance_profile_id: "AID2MAB8DPLSRHEXAMPLE",
        instance_profile_name: "ExampleInstanceProfile",
        path: "/",
        roles: [],
    }
    iam_data[:client] = Aws::IAM::Client
    iam_data[:data] = { :instance_profile => mock_iam }
    @ec2 = AwsEc2Instance.new(instance_id: 'i-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data, iam_data])
  end

  def test_ec2_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_has_no_roles
    refute @ec2.has_roles?
  end

  def test_no_role
    assert_nil(@ec2.role)
  end

  def test_no_name
    assert_nil(@ec2.name)
  end

  def test_no_tags
    assert_equal(@ec2.tags, [])
  end

  def test_no_tags_hash
    assert_equal(@ec2.tags_hash, {})
  end
end

class AwsEc2InstanceHasRolesTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_instances
    mock_ec2 = {}
    mock_ec2[:instance_id] = 'i-00b5186ddefdb50bf'
    mock_ec2[:iam_instance_profile] = { arn: 'arn:aws:iam::336924118301:instance-profile/InSpecInstanceProfile' }
    data[:data] = { :reservations => [{ :instances => [mock_ec2] }] }
    data[:client] = Aws::EC2::Client
    iam_data = {}
    iam_data[:method] = :get_instance_profile
    mock_iam = {
        arn: "arn:aws:iam::336924118301:instance-profile/InSpecInstanceProfile",
        create_date: Time.parse("2013-06-12T23:52:02Z"),
        instance_profile_id: "AID2MAB8DPLSRHEXAMPLE",
        instance_profile_name: "InSpecInstanceProfile",
        path: "/",
        roles: [
            {
                arn: "arn:aws:iam::336924118301:role/InSpec-Test-Role",
                assume_role_policy_document: "<URL-encoded-JSON>",
                create_date: Time.parse("2013-01-09T06:33:26Z"),
                path: "/",
                role_id: "AIDGPMS9RO4H3FEXAMPLE",
                role_name: "Test-Role",
            },
        ],
    }
    iam_data[:client] = Aws::IAM::Client
    iam_data[:data] = { :instance_profile => mock_iam }
    @ec2 = AwsEc2Instance.new(instance_id: 'i-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data, iam_data])
  end

  def test_ec2_id
    assert_equal(@ec2.instance_id, 'i-00b5186ddefdb50bf')
  end

  def test_has_roles
    assert @ec2.has_roles?
  end

  def test_role
    assert_equal(@ec2.role, "Test-Role")
  end
end
