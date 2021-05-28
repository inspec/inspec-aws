require 'helper'
require 'aws_ec2_launch_templates'
require 'aws-sdk-core'

class AwsLaunchTemplatesTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2LaunchTemplates.new(rubbish: 9,client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2LaunchTemplates.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2LaunchTemplates.new(rubbish: 9) }
  end

end

class AwsLaunchTemplatesPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_launch_templates
    mock_eip = {}
    mock_eip[:launch_template_name] = 'test'
    mock_eip[:launch_template_id] = 'lt-01a6e9ac9f962f154'
    mock_eip[:created_by] = 'test-account'
    mock_eip[:latest_version_number] = 1
    mock_eip[:default_version_number] = 1
    data[:data] = { :launch_templates => [mock_eip] }
    data[:client] = Aws::EC2::Client
    @addr = AWSEc2LaunchTemplates.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_launch_template_exists
    assert @addr.exists?
  end

  def test_launch_template_available
    assert @addr.available?
  end
end
