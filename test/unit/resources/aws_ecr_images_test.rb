require 'helper'
require 'aws_ecr_images'
require "aws-sdk-core"
require_relative 'mock/aws_ecr_image_mock'

class AwsEcrImagesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcrImages.new() }
  end

  def test_invalid_repo_name
    assert_raises(ArgumentError) { AwsEcrImages.new(repository_name: '-aa') }
  end

  def test_too_long_repo_name
    assert_raises(ArgumentError) { AwsEcrImages.new(repository_name: 'a'*257) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsEcrImages.new(rubbish_id: 'fs-12345678') }
  end

  def test_valid_repo_name
    assert AwsEcrImages.new(repository_name: 'my-repo', client_args: { stub_responses: true })
  end

  def test_non_existing_image
    refute AwsEcrImages.new(repository_name: 'my-repo', client_args: { stub_responses: true }).exist?
  end

end

class AwsEcrImagesTest < Minitest::Test

  def setup
    # Create a mock image
    number_of_mock = 5
    @mock_image_list = AwsEcrImageMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :image_details => @mock_image_list }
    data[:client] = Aws::ECR::Client
    data[:method] = :describe_images

    # Create a stub image with mock data.
    @ecr_images = AwsEcrImages.new(
        repository_name: @mock_image_list[0][:repository_name],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_image_exists
    assert @ecr_images.exist?
  end

  def test_image_digest
    @ecr_images.digests.zip(@mock_image_list).each do |e_i_d, m_i|
      assert_equal(e_i_d, m_i[:image_digest])
    end
  end

  def test_image_tags
    @ecr_images.tags.zip(@mock_image_list).each do |e_i_t, m_i|
      assert_equal(e_i_t, m_i[:image_tags])
    end
  end

  def test_image_scan_status
    @ecr_images.vulnerability_scan_status.zip(@mock_image_list).each do |e_i_s, m_i|
      assert_equal(e_i_s, m_i[:image_scan_status][:status])
    end
  end

  def test_image_scan_findings_summary
    @ecr_images.vulnerability_severity_counts.zip(@mock_image_list).each do |e_i_v, m_i|
      assert_equal(e_i_v, m_i[:image_scan_findings_summary][:finding_severity_counts])
    end
  end

  def test_size_in_bytes
    @ecr_images.size_in_bytes.zip(@mock_image_list).each do |e_i_s, m_i|
      assert_equal(e_i_s, m_i[:image_size_in_bytes])
    end
  end

  def test_pushed_at_dates
    @ecr_images.pushed_at_dates.zip(@mock_image_list).each do |e_i_d, m_i|
      assert_equal(e_i_d, m_i[:image_pushed_at])
    end
  end
end
