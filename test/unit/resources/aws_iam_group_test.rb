require 'helper'
require 'aws-sdk-core'
require 'aws_iam_group'
require_relative 'mock/iam/aws_iam_group_mock'

class AwsIamGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamGroup.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_group_name
    AwsIamGroup.new(group_name: 'group-name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsIamGroup.new(rubbish: 9) }
  end

  def test_group_not_existing
    refute AwsIamGroup.new(group_name: 'group-not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsIamGroupTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamGroupMock.new
    @mock_iam_group = @mock.group

    # When
    @iam_group = AwsIamGroup.new(group_name: @mock_iam_group[:group][:group_name],
                                 client_args: { stub_responses: true },
                                 stub_data: @mock.stub_data)
  end

  def test_iam_group_name
    assert_equal(@iam_group.group_name, @mock_iam_group[:group][:group_name])
  end

  def test_iam_group_id
    assert_equal(@iam_group.group_id, @mock_iam_group[:group][:group_id])
  end

  def test_iam_arn
    assert_equal(@iam_group.arn, @mock_iam_group[:group][:arn])
  end

  def test_iam_users
    assert_equal(@iam_group.users.first, @mock_iam_group[:users].first[:user_name])
  end

  def test_exists
    assert @iam_group.exists?
  end
end