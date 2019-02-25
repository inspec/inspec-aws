require 'aws-sdk-core'
require 'aws_organizations_member'
require 'helper'
require_relative 'mock/aws_organizations_member_mock'

class AwsOrganizationsMemberTest < Minitest::Test

  def test_constructor
    # Given
    mock = AwsOrganizationsMemberMock.new
    @mock_account = mock.account
    @mock_org = mock.organization
    stub_data = mock.stub_data(true)

    # When
    @org_member = AwsOrganizationsMember.new(client_args: { stub_responses: true }, stub_data: stub_data)

    # Then
    assert_equal(@org_member.master_account_id, @mock_org[:master_account_id])
    assert_equal(@org_member.master_account_arn, @mock_org[:master_account_arn])
    assert_equal(@org_member.master_account_id, @mock_account[:id])
    assert_equal(@org_member.account_arn, @mock_account[:arn])
    assert_equal(@org_member.account_name, @mock_account[:name])
    assert_equal(@org_member.account_email, @mock_account[:email])
  end

  def test_no_params_allowed
    assert_raises(ArgumentError) { AwsOrganizationsMember.new(arguments_not_allowed: 'expect_failure') }
  end

  def test_exists
    # Given
    mock = AwsOrganizationsMemberMock.new
    stub_data = mock.stub_data(false)

    # When
    org_member = AwsOrganizationsMember.new(client_args: { stub_responses: true }, stub_data: stub_data)

    # Then
    assert(org_member.exists?)
  end

  def test_not_master_account
    # Given
    mock = AwsOrganizationsMemberMock.new
    stub_data = mock.stub_data(false)

    # When
    org_member = AwsOrganizationsMember.new(client_args: { stub_responses: true }, stub_data: stub_data)

    # Then
    assert(!org_member.master?)
    assert_nil(org_member.account_arn)
    assert_nil(org_member.account_email)
    assert_nil(org_member.account_id)
    assert_nil(org_member.account_name)
  end

  def test_is_master_account
    # Given
    mock = AwsOrganizationsMemberMock.new
    mock_account = mock.account
    stub_data = mock.stub_data(true)

    # When
    org_member = AwsOrganizationsMember.new(client_args: { stub_responses: true }, stub_data: stub_data)

    # Then
    assert(org_member.master?)
    assert_equal(org_member.master_account_id, mock_account[:id])
    assert_equal(org_member.account_arn, mock_account[:arn])
    assert_equal(org_member.account_name, mock_account[:name])
    assert_equal(org_member.account_email, mock_account[:email])
  end
end
