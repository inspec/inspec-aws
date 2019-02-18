require 'aws-sdk-core'
require 'aws_iam_access_key'
require 'helper'
require_relative 'mock/iam/aws_iam_access_key_mock'

class AwsIamAccessKey < Minitest::Test

  def setup
    # Given
    @mock = AwsIamAccessKeyMock.new
    @mock_access_key = @mock.access_key

    # When
    @access_key = AwsIamAccessKey.new(username: @mock_user[:user_name],
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamAccessKey.new(client_args: { stub_responses: true }) }
  end

  def test_username
    assert_equal(@access_key.username, @mock_access_key[:user_name])
  end

  def test_access_key_id
    assert_equal(@access_key.access_key_id, @mock_access_key[:access_key_id])
  end

  def test_create_date
    assert_equal(@access_key.create_date, @mock_access_key[:create_date])
  end

  def test_status
    assert_equal(@access_key.status, @mock_access_key[:status])
  end

  def test_active
    assert_equal(@access_key.active?, @mock_access_key[:status] == 'Active')
  end

  def test_last_access_date
    assert_equal(@access_key.last_used_date, @mock.last_used.access_key_last_used.last_used_date)
  end

  def test_exists
    assert(@access_key.exists?)
  end
end
