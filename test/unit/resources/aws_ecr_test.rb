require 'helper'
require 'aws-sdk-core'
require 'aws_ecr'
require_relative 'mock/aws_ecr_mock'

class AwsEcrConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcr.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_repository_name
    AwsEcr.new(repository_name: 'repo-name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEcr .new(rubbish: 9) }
  end

  def test_ecr_not_existing
    refute AwsEcr.new(repository_name: 'repo-not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsEcrTest < Minitest::Test

  def setup
    # Given
    @mock = AwsEcrMock.new
    @mock_ecr = @mock.ecr[:repositories].first

    # When
    @ecr = AwsEcr.new(repository_name: @mock_ecr[:repository_name],
                                 client_args: { stub_responses: true },
                                 stub_data: @mock.stub_data)
  end

  def test_resource_id
    refute_nil(@ecr.resource_id)
    assert_equal(@ecr.resource_id, @mock_ecr[:repository_name])
  end

  def test_repository_name
    assert_equal(@ecr.repository_name, @mock_ecr[:repository_name])
  end

  def test_repository_arn
    assert_equal(@ecr.repository_arn, @mock_ecr[:repository_arn])
  end

  def test_registry_id
    assert_equal(@ecr.registry_id, @mock_ecr[:registry_id])
  end

  def test_created_at
    assert_equal(@ecr.created_at.to_s, @mock_ecr[:created_at].to_s)
  end

  def test_repository_uri
    assert_equal(@ecr.repository_uri, @mock_ecr[:repository_uri])
  end

  def test_exists
    assert @ecr.exists?
  end
end