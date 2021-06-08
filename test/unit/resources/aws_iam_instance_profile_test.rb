require 'helper'
require 'aws_iam_instance_profile'
require 'aws-sdk-core'

class AWSIAMInstanceProfileConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSIAMInstanceProfile.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSIAMInstanceProfile.new(instance_profile_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSIAMInstanceProfile.new(unexpected: 9) }
  end
end

class AWSIAMInstanceProfileSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_instance_profile
    mock_parameter = {}
    mock_parameter[:path] = 'test1'
    mock_parameter[:instance_profile_name] = 'test1'
    mock_parameter[:instance_profile_id] = 'test1'
    mock_parameter[:arn] = 'test1'
    mock_parameter[:roles] = []
    mock_parameter[:create_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { instance_profile: mock_parameter }
    data[:client] = Aws::IAM::Client
    @instance_profile = AWSIAMInstanceProfile.new(instance_profile_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @instance_profile.exists?
  end

  def test_path
    assert_equal(@instance_profile.path, 'test1')
  end

  def test_instance_profile_name
    assert_equal(@instance_profile.instance_profile_name, 'test1')
  end

  def test_instance_profile_id
    assert_equal(@instance_profile.instance_profile_id, 'test1')
  end

  def test_instance_profile_arn
    assert_equal(@instance_profile.arn, 'test1')
  end
end