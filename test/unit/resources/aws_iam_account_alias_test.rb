require 'aws-sdk-core'
require 'aws_iam_account_alias'
require 'helper'
require_relative 'mock/iam/aws_iam_account_alias_mock'

class AwsIamAccountAliasTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamAccountAliasMock.new
    @mock_alias = @mock.alias

    # When
    @alias = AwsIamAccountAlias.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data)
  end

  def test_exists
    assert(@alias.exists?)
  end

  def test_alias_name
    assert_equal(@alias.alias, @mock_alias[:account_aliases][0])
  end

end