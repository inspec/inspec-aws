require 'aws-sdk-core'
require 'aws_iam_role'
require 'helper'
require_relative 'mock/iam/aws_iam_role_mock'

class AwsIamRoleTest < Minitest::Test

  def setup
    # Given
    @mock      = AwsIamRoleMock.new
    @mock_role = @mock.role[:role]

    # When
    @role = AwsIamRole.new(role_name: @mock.role_name,
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_exists
    assert(@role.exists?)
  end

  def test_role_name
    assert_equal(@role.role_name, @mock_role[:role_name])
  end

  def test_role_id
    assert_equal(@role.role_id, @mock_role[:role_id])
  end

  def test_arn
    assert_equal(@role.arn, @mock_role[:arn])
  end

  def test_description
    assert_equal(@role.description, @mock_role[:description])
  end

  def test_create_date
    assert(@role.create_date.to_i == @mock_role[:create_date].to_i)
  end

  def test_path
    assert_equal(@role.path, @mock_role[:path])
  end

  def test_permission_boundaries
    assert_nil(@role.permissions_boundary_type)
    assert_nil(@role.permissions_boundary_arn)
  end

end

class AwsIamRoleAttachedPolicyTest < Minitest::Test

  def setup
    # Given
    @mock      = AwsIamRoleMock.new
    @mock_attached_policies = @mock.attached_policy_name

    # When
    @role = AwsIamRole.new(role_name: @mock.role_name,
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_exists
    assert(@role.exists?)
  end

  def test_attached_policy_name_exists
    assert_equal(@role.attached_policies_names[0], @mock.attached_policy_name)
  end

  def test_attached_policy_arn_exists
    assert_equal(@role.attached_policies_arns[0], @mock.attached_policy_arn)
  end

end

class AwsIamRoleInlinePolicyTest < Minitest::Test

  def setup
    # Given
    @mock      = AwsIamRoleMock.new
    @mock_inline_policies = @mock.inline_policies[:policy_names]

    # When
    @role = AwsIamRole.new(role_name: @mock.role_name,
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_exists
    assert(@role.exists?)
  end

  def test_inline_policy_name_exists
    assert_equal(@role.inline_policies[0], @mock.inline_policy_name)
  end

end