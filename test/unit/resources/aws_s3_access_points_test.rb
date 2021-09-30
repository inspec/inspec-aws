require 'helper'
require 'aws_s3_access_points'
require 'aws-sdk-core'

class AWSS3AccessPointsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSS3AccessPoints.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSS3AccessPoints.new('rubbish') }
  end
end

class AWSS3AccessPointsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_bucket_metrics_configurations
    mock_parameter = {}
    mock_parameter[:id] = 'test-id'
    mock_parameter[:filter] = { access_point_arn: "test1" }
    data[:data] = { :metrics_configuration_list => [mock_parameter] }
    data[:client] = Aws::S3::Client
    @access_point = AWSS3AccessPoints.new(bucket_name: "test1", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @access_point.exist?
  end

  def test_compute_environment_names
    assert_equal(@access_point.access_point_arns, ['test1'])
  end
end