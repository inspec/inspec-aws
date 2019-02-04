require 'helper'
require 'aws-sdk-core'
require 'aws_iam_group'

class AwsIamGroupConstructorTest < Minitest::Test

  def setup
    @mock_iam_group = {}
    @mock_iam_group[:group] = {group_name: 'rooty-tooty-pointy-shooty',
                               group_id: "AGPAJNTWBNRUUY4MZC7P2",
                               arn: "arn:aws:iam::510367013858:group/compliance-scans",
                               create_date: Time.now.utc,
                               path: "/"}
    @mock_iam_group[:users] = [{path: "/",
                                user_name: "rooty-tooty",
                                user_id: "AAAAAAAABBBBBBBBBBBB1",
                                arn: "arn:aws:iam::111111111111:user/arnold",
                                password_last_used: nil,
                                permissions_boundary: nil,
                                create_date: Time.now.utc,
                                tags: []}]

    stub_data = {}
    stub_data[:method] = :get_group
    stub_data[:data]   = @mock_iam_group
    stub_data[:client] = Aws::IAM::Client

    @iam_group = AwsIamGroup.new(group_name: @mock_iam_group[:group][:group_name],
                                 client_args: { stub_responses: true },
                                 stub_data: [stub_data])
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamGroup.new(client_args: { stub_responses: true }) }
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