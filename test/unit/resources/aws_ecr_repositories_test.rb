require 'helper'
require 'aws_ecr_repositories'
require "aws-sdk-core"
require_relative 'mock/aws_ecr_repository_mock'

class AwsEcrRepositoriesConstructorTest < Minitest::Test

  def test_params_not_ok
    assert_raises(ArgumentError) { AwsEcrRepositories.new(repository_name: 'my-repo') }
  end

  def test_empty_params_ok
    assert AwsEcrRepositories.new(client_args: { stub_responses: true })
  end

  def test_non_existing_repositories
    refute AwsEcrRepositories.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEcrRepositoriesTest < Minitest::Test

  def setup
    # Create a number of mock repositories
    number_of_mock = 5
    @mock_repo_list = AwsEcrRepositoryMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :repositories => @mock_repo_list }
    data[:client] = Aws::ECR::Client
    data[:method] = :describe_repositories

    # Create a number of stub ECR repos with mock data.
    @ecr_repos = AwsEcrRepositories.new(
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_repo_exist
    assert @ecr_repos.exist?
  end

  def test_repository_arn
    @ecr_repos.arns.zip(@mock_repo_list).each do |e_r_a, m_r|
      assert_equal(e_r_a, m_r[:repository_arn])
    end
  end

  def test_repository_name
    @ecr_repos.names.zip(@mock_repo_list).each do |e_r_n, m_r|
      assert_equal(e_r_n, m_r[:repository_name])
    end
  end

  def test_image_tag_mutability
    @ecr_repos.image_tag_mutability_status.zip(@mock_repo_list).each do |e_r_t, m_r|
      assert_equal(e_r_t, m_r[:image_tag_mutability])
    end

  end

  def test_scan_on_push
    @ecr_repos.image_scanning_on_push_status.zip(@mock_repo_list).each do |e_r_s, m_r|
      assert_equal(e_r_s, m_r[:image_scanning_configuration][:scan_on_push])
    end
  end

  def test_created_at
    @ecr_repos.created_at_dates.zip(@mock_repo_list).each do |e_r_c, m_r|
      assert_equal(e_r_c, m_r[:created_at])
    end
  end

  def test_repository_uri
    @ecr_repos.uris.zip(@mock_repo_list).each do |e_r_u, m_r|
      assert_equal(e_r_u, m_r[:repository_uri])
    end
  end
end
