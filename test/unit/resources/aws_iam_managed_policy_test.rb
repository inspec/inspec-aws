require 'helper'
require 'aws_iam_managed_policy'
require 'aws-sdk-core'

class AWSIAMManagedPolicyTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamManagedPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsIamManagedPolicy.new('rubbish') }
  end

  def test_iam_client_non_existing_for_empty_response
    refute AwsIamManagedPolicy.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsIamManagedPolicyHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_profile
    mock_data = {}
    mock_data[:path] = 'test1'
    mock_data[:policy_name] = 'test1'
    mock_data[:policy_id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:roles] = []
    mock_data[:create_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :policy => [mock_data] }
    data[:client] = Aws::IAM::Client
    @iam_client = AwsIamManagedPolicy.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_iam_client_exists
    assert @iam_client.exist?
  end

  def test_paths
    assert_equal(@iam_client.paths, 'test1')
  end

  def test_policy_names
    assert_equal(@iam_client.instance_profile_names, 'test1')
  end

  def test_instance_profile_ids
    assert_equal(@iam_client.instance_profile_ids, 'test1')
  end

  def test_arns
    assert_equal(@iam_client.arns, 'test1')
  end
end