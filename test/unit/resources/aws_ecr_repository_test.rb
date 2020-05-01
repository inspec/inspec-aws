require 'helper'
require 'aws_ecr_repository'
require "aws-sdk-core"
require_relative 'mock/aws_ecr_repository_mock'

class AwsEcrRepositoryConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcrRepository.new() }
  end

  def test_invalid_repository_name
    assert_raises(ArgumentError) { AwsEcrRepository.new(repository_name: '-a') }
  end

  def test_invalid_registry_id
    assert_raises(ArgumentError) { AwsEcrRepository.new(registry_id: 'a234',repository_name: 'my-repo') }
  end

  def test_too_long_repository_name
    assert_raises(ArgumentError) { AwsEcrRepository.new('a'*257) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsEcrRepository.new(rubbish_id: 'fs-12345678') }
  end

  def test_valid_repository_name
    assert AwsEcrRepository.new(repository_name: 'my-repo', client_args: { stub_responses: true })
  end

  def test_non_existing_repository
    refute AwsEcrRepository.new(repository_name: 'my-repo', client_args: { stub_responses: true }).exists?
  end

end

class AwsEcrRepositoryTest < Minitest::Test

  def setup
    # Create a mock repository
    number_of_mock = 1
    @mock_repo_list = AwsEcrRepositoryMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :repositories => @mock_repo_list }
    data[:client] = Aws::ECR::Client
    data[:method] = :describe_repositories

    # This is for brevity.
    @m_r = @mock_repo_list.first

    # Create a stub ECR repo with mock data.
    @ecr_repo = AwsEcrRepository.new(
        repository_name: @m_r[:repository_name],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_repo_exists
    assert @ecr_repo.exists?
  end

  def test_repository_arn
    assert_equal(@ecr_repo.repository_arn, @m_r[:repository_arn])
  end

  def test_registry_id
    assert_equal(@ecr_repo.registry_id, @m_r[:registry_id])
  end

  def test_repository_name
    assert_equal(@ecr_repo.repository_name, @m_r[:repository_name])
  end

  def test_image_tag_mutability
    assert_equal(@ecr_repo.image_tag_mutability, @m_r[:image_tag_mutability])
  end

  def test_scan_on_push
    assert_equal(@ecr_repo.image_scanning_configuration.scan_on_push, @m_r[:image_scanning_configuration][:scan_on_push])
  end

  def test_created_at
    assert_equal(@ecr_repo.created_at, @m_r[:created_at])
  end

  def test_repository_uri
    assert_equal(@ecr_repo.repository_uri, @m_r[:repository_uri])
  end
end
