require 'helper'
require 'aws_ec2_launch_template'
require 'aws-sdk-core'

class AwsLaunchTemplateTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2LaunchTemplate.new(rubbish: 9,client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2LaunchTemplate.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2LaunchTemplate.new(rubbish: 9) }
  end

  def test_rejects_invalid_launch_template_endpoint_id
    assert_raises(ArgumentError) { AWSEc2LaunchTemplate.new(launch_template_id1: 'test') }
  end
end

class AwsLaunchTemplatePathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_launch_templates
    mock_lt = {}
    mock_lt[:launch_template_name] = 'test'
    mock_lt[:launch_template_id] = 'lt-01a6e9ac9f962f154'
    mock_lt[:created_by] = 'test-account'
    mock_lt[:latest_version_number] = 1
    mock_lt[:default_version_number] = 1
    data[:data] = { :launch_templates => [mock_lt] }
    data[:client] = Aws::EC2::Client
    @addr = AWSEc2LaunchTemplate.new(launch_template_name: 'test',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_launch_template_exists
    assert @addr.exists?
  end

  def test_launch_template_name
    assert_equal(@addr.launch_template_name, "test")
  end

  def test_launch_template_id
    assert_equal(@addr.launch_template_id, "lt-01a6e9ac9f962f154")
  end

  def test_latest_version_number
    assert_equal(@addr.latest_version_number, 1)
  end

  def test_default_version_number
    assert_equal(@addr.default_version_number, 1)
  end
end
