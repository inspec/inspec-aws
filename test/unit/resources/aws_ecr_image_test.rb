require 'helper'
require 'aws_ecr_image'
require "aws-sdk-core"
require_relative 'mock/aws_ecr_image_mock'

class AwsEcrImageConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcrImage.new() }
  end

  def test_invalid_image_digest
    assert_raises(ArgumentError) { AwsEcrImage.new(repository_name: 'aa', image_digest: 'aa') }
  end

  def test_too_long_image_tag
    assert_raises(ArgumentError) { AwsEcrImage.new(repository_name: 'aa', image_tag: 'a'*301) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsEcrImage.new(repository_name: 'aa', rubbish_id: 'fs-12345678') }
  end

  def test_valid_image_tag
    assert AwsEcrImage.new(repository_name: 'my-repo', image_tag: 'latest', client_args: { stub_responses: true })
  end

  def test_non_existing_image
    refute AwsEcrImage.new(repository_name: 'my-repo', image_tag: 'latest', client_args: { stub_responses: true }).exists?
  end

end

class AwsEcrImageTest < Minitest::Test

  def setup
    # Create a mock image
    number_of_mock = 1
    @mock_image_list = AwsEcrImageMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :image_details => @mock_image_list }
    data[:client] = Aws::ECR::Client
    data[:method] = :describe_images

    # This is for brevity.
    @m_i = @mock_image_list.first

    # Create a stub image with mock data.
    @ecr_image = AwsEcrImage.new(
        repository_name: @m_i[:repository_name],
        image_tag: @m_i[:image_tags][0],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_image_exists
    assert @ecr_image.exists?
  end

  def test_image_digest
    assert_equal(@ecr_image.image_digest, @m_i[:image_digest])
  end

  def test_image_tag
    assert_equal(@ecr_image.image_tags, @m_i[:image_tags])
  end

  def test_image_scan_status
    assert_equal(@ecr_image.image_scan_status.status, @m_i[:image_scan_status][:status])
  end

  def test_image_scan_findings_summary
    assert_equal(@ecr_image.image_scan_findings_summary.finding_severity_counts.item, @m_i[:image_scan_findings_summary][:finding_severity_counts])
  end

  def test_registry_id
    assert_equal(@ecr_image.registry_id, @m_i[:registry_id])
  end

  def test_repository_name
    assert_equal(@ecr_image.repository_name, @m_i[:repository_name])
  end
end
