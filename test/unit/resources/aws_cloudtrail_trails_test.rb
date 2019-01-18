require 'helper'
require 'aws_cloudtrail_trails'
require 'aws-sdk-core'

class AwsCloudTrailTrailsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsCloudTrailTrails.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsCloudTrailTrails.new('rubbish') }
  end

  def test_cloudtrails_non_existing_for_empty_response
    refute AwsCloudTrailTrails.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsCloudTrailTrailsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_trails
    mock_cloudtrail_trail = {}
    mock_cloudtrail_trail[:name] = 'aws-cloud-trail-a'
    mock_cloudtrail_trail[:trail_arn] = 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail-a'
    another_mock_cloudtrail_trail = {}
    another_mock_cloudtrail_trail[:name] = 'aws-cloud-trail-b'
    another_mock_cloudtrail_trail[:trail_arn] = 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail-b'
    data[:data] = { :trail_list => [mock_cloudtrail_trail, another_mock_cloudtrail_trail] }
    data[:client] = Aws::CloudTrail::Client
    @cloudtrails = AwsCloudTrailTrails.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_cloudtrails_exists
    assert @cloudtrails.exist?
  end

  def test_cloudtrails_count
    assert_equal(@cloudtrails.names.count, 2)
    assert_equal(@cloudtrails.trail_arns.count, 2)
  end

  def test_cloudtrails_names
    assert_equal(@cloudtrails.names, ['aws-cloud-trail-a', 'aws-cloud-trail-b'])
  end

  def test_cloudtrails_trail_arns
    assert_equal(@cloudtrails.trail_arns, ['arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail-a', 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail-b'])
  end

  def test_cloudtrails_filtering_not_there
    refute @cloudtrails.where(:trail_arn => 'bad').exist?
    refute @cloudtrails.where(:name => 'bad').exist?
  end

  def test_cloudtrails_filtering_there
    assert @cloudtrails.where(:name => 'aws-cloud-trail-a').exist?
    assert @cloudtrails.where(:trail_arn => 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail-a').exist?
  end
end