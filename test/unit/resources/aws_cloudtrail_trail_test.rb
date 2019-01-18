require 'helper'
require 'aws_cloudtrail_trail'
require 'aws-sdk-core'

class AwsCloudTrailTrailConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudTrailTrail.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudTrailTrail.new(rubbish: 9) }
  end

  def test_cloudtrail_non_existing
    refute AwsCloudTrailTrail.new(trail_name: 'cloudtrail-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsCloudTrailTrailPositiveTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_trails
    mock_cloudtrail_trail = {}
    mock_cloudtrail_trail[:name] = 'aws-cloud-trail'
    mock_cloudtrail_trail[:s3_bucket_name] = 'aws-cloud-trail-bucket'
    mock_cloudtrail_trail[:is_multi_region_trail] = true
    mock_cloudtrail_trail[:home_region] = 'eu-west-2'
    mock_cloudtrail_trail[:trail_arn] = 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail'
    mock_cloudtrail_trail[:log_file_validation_enabled] = true
    mock_cloudtrail_trail[:cloud_watch_logs_log_group_arn] = 'arn:aws:logs:eu-west-2::log-group:test:*'
    mock_cloudtrail_trail[:cloud_watch_logs_role_arn] = 'arn:aws:iam:::role/CloudTrail_CloudWatchLogs_Role'
    mock_cloudtrail_trail[:kms_key_id] = 'arn:aws:kms:eu-west-2::key//df4947b2-c059-4e2f-8794-af07231ddb17'
    data[:data] = { :trail_list => [mock_cloudtrail_trail] }
    data[:client] = Aws::CloudTrail::Client
    status = {}
    status[:method] = :get_trail_status
    status[:data] = { :latest_cloud_watch_logs_delivery_time => Time.now - 30 * 24 * 60 * 60 }
    status[:client] = Aws::CloudTrail::Client
    @cloudtrail_trail = AwsCloudTrailTrail.new(trail_name: 'aws-cloud-trail', client_args: { stub_responses: true }, stub_data: [data, status])
  end

  def test_cloudtrail_trail_name
    assert_equal(@cloudtrail_trail.trail_name, 'aws-cloud-trail')
  end

  def test_cloudtrail_trail_s3_bucket_name
    assert_equal(@cloudtrail_trail.s3_bucket_name, 'aws-cloud-trail-bucket')
  end

  def test_cloudtrail_trail_is_multi_region_trail
    assert_equal(@cloudtrail_trail.is_multi_region_trail, true)
  end

  def test_cloudtrail_trail_home_region
    assert_equal(@cloudtrail_trail.home_region, 'eu-west-2')
  end

  def test_cloudtrail_trail_trail_arn
    assert_equal(@cloudtrail_trail.trail_arn, 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail')
  end

  def test_cloudtrail_trail_log_file_validation_enabled
    assert_equal(@cloudtrail_trail.log_file_validation_enabled, true)
  end

  def test_cloudtrail_trail_cloud_watch_logs_log_group_arn
    assert_equal(@cloudtrail_trail.cloud_watch_logs_log_group_arn, 'arn:aws:logs:eu-west-2::log-group:test:*')
  end

  def test_cloudtrail_trail_cloud_watch_logs_role_arn
    assert_equal(@cloudtrail_trail.cloud_watch_logs_role_arn, 'arn:aws:iam:::role/CloudTrail_CloudWatchLogs_Role')
  end

  def test_cloudtrail_trail_kms_key_id
    assert_equal(@cloudtrail_trail.kms_key_id, 'arn:aws:kms:eu-west-2::key//df4947b2-c059-4e2f-8794-af07231ddb17')
  end

  def test_encrypted_positive
    assert @cloudtrail_trail.encrypted?
  end

  def test_multi_region_trail_positive
    assert @cloudtrail_trail.multi_region_trail?
  end

  def test_log_file_validation_enabled_positive
    assert @cloudtrail_trail.log_file_validation_enabled?
  end
end

class AwsCloudTrailTrailNegativeTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_trails
    mock_cloudtrail_trail = {}
    mock_cloudtrail_trail[:name] = 'aws-cloud-trail-negative'
    mock_cloudtrail_trail[:s3_bucket_name] = 'aws-cloud-trail-bucket2'
    mock_cloudtrail_trail[:is_multi_region_trail] = false
    mock_cloudtrail_trail[:home_region] = 'eu-west-2'
    mock_cloudtrail_trail[:trail_arn] = 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail'
    mock_cloudtrail_trail[:log_file_validation_enabled] = false
    data[:data] = { :trail_list => [mock_cloudtrail_trail] }
    data[:client] = Aws::CloudTrail::Client
    @cloudtrail_trail = AwsCloudTrailTrail.new(trail_name: 'aws-cloud-trail-negative', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_cloudtrail_trail_name
    assert_equal(@cloudtrail_trail.trail_name, 'aws-cloud-trail-negative')
  end

  def test_cloudtrail_trail_s3_bucket_name
    assert_equal(@cloudtrail_trail.s3_bucket_name, 'aws-cloud-trail-bucket2')
  end

  def test_cloudtrail_trail_is_multi_region_trail
    assert_equal(@cloudtrail_trail.is_multi_region_trail, false)
  end

  def test_cloudtrail_trail_home_region
    assert_equal(@cloudtrail_trail.home_region, 'eu-west-2')
  end

  def test_cloudtrail_trail_trail_arn
    assert_equal(@cloudtrail_trail.trail_arn, 'arn:aws:cloudtrail:eu-west-2::trail/aws-cloud-trail')
  end

  def test_cloudtrail_trail_log_file_validation_enabled
    assert_equal(@cloudtrail_trail.log_file_validation_enabled, false)
  end

  def test_encrypted_negative
    refute @cloudtrail_trail.encrypted?
  end

  def test_multi_region_trail_negative
    refute @cloudtrail_trail.multi_region_trail?
  end

  def test_log_file_validation_enabled_negative
    refute @cloudtrail_trail.log_file_validation_enabled?
  end
end