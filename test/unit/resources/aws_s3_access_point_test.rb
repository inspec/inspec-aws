require 'helper'
require 'aws_s3_access_point'
require 'aws-sdk-core'

class AWSS3AccessPointConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSS3AccessPoint.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSS3AccessPoint.new(bucket_name: '', metrics_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSS3AccessPoint.new(unexpected: 9) }
  end
end

class AWSS3AccessPointHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_bucket_metrics_configuration
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:filter] = {
      prefix: "test1",
      access_point_arn: "test1"
    }
    data[:data] = { metrics_configuration: mock_data }
    data[:client] = Aws::S3::Client
    @resp = AWSS3AccessPoint.new(bucket_name: 'test1', metrics_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @resp.exist?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_access_point_arn
    assert_equal(@resp.filter.access_point_arn, 'test1')
  end
end