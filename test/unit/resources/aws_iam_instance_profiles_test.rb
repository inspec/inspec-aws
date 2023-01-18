require 'helper'
require 'aws_iam_instance_profiles'
require 'aws-sdk-core'

class AWSIAMInstanceProfilesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSIAMInstanceProfiles.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSIAMInstanceProfiles.new('rubbish') }
  end

  def test_instance_profiles_non_existing_for_empty_response
    refute AWSIAMInstanceProfiles.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSIAMInstanceProfilesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_instance_profiles
    mock_data = {}
    mock_data[:path] = 'test1'
    mock_data[:instance_profile_name] = 'test1'
    mock_data[:instance_profile_id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:roles] = []
    mock_data[:create_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :instance_profiles => [mock_data] }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMInstanceProfiles.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instance_profiles_exists
    assert @resp.exist?
  end

  def test_paths
    assert_equal(@resp.paths, ['test1'])
  end

  def test_instance_profile_names
    assert_equal(@resp.instance_profile_names, ['test1'])
  end

  def test_instance_profile_ids
    assert_equal(@resp.instance_profile_ids, ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns, ['test1'])
  end
end