require 'helper'
require 'aws_ami'
require 'aws-sdk-core'

class AwsAmiGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsAmi.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsAmi.new(image_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsAmi.new(unexpected: 9) }
  end
end

class AwsAmiSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_images
    mock_image = {}
    mock_image[:architecture] = 'x86_64'
    mock_image[:creation_date] =  "2016-09-23T16:45:02.000Z"
    mock_image[:image_id] = 'aki-12345678'
    mock_image[:image_location] = 'ami/manifest.xml'
    mock_image[:image_type] = "kernel"
    mock_image[:public] = true
    mock_image[:kernel_id] = "k-23412d32"
    mock_image[:owner_id] = "547327432"
    mock_image[:platform] = ""
    mock_image[:platform_details] = "Linux/UNIX"
    mock_image[:usage_operation] = "RunInstances"
    mock_image[:product_codes] = []
    mock_image[:ramdisk_id] = "D1654"
    mock_image[:state] = "available"
    mock_image[:block_device_mappings] = []
    mock_image[:description] = "PV-GRUB release 1.04"
    mock_image[:ena_support] = false
    mock_image[:hypervisor] = "xen"
    mock_image[:image_owner_alias] = "amazon"
    mock_image[:name] = "default_name.gz"
    mock_image[:root_device_name] = "/dev/sda1"
    mock_image[:root_device_type] = "instance_store"
    mock_image[:sriov_net_support] = ""
    mock_image[:state_reason] = {}
    mock_image[:tags] = []
    mock_image[:virtualization_type] = "paravirtual"
    data[:data] = { images: [mock_image] }
    data[:client] = Aws::EC2::Client
    @ami = AwsAmi.new(image_id: 'aki-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_image_exists
    assert @ami.exists?
  end

  def test_image_architecture
    assert_equal(@ami.architecture, 'x86_64')
  end

  def test_image_location
    assert_equal(@ami.image_location, 'ami/manifest.xml')
  end

  def test_image_type
    assert_equal(@ami.image_type, 'kernel')
  end

  def test_image_public
    assert_equal(@ami.public, true)
  end

  def test_image_owner_id
    assert_equal(@ami.owner_id, '547327432')
  end

  def test_image_state
    assert_equal(@ami.state, 'available')
  end

  def test_image_name
    assert_equal(@ami.name, 'default_name.gz')
  end
end