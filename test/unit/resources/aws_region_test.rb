require 'helper'
require 'aws_region'
require 'aws-sdk-core'

class AwsRegionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRegion.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_region_name
    AwsRegion.new(region_name: 'region-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRegion.new(rubbish: 9) }
  end

  def test_region_non_existing
    refute AwsRegion.new(region_name: 'region-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRegionTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_regions
    region = {}
    region[:endpoint] = 'ec2.eu-west-2.amazonaws.com'
    region[:region_name] = 'eu-west-2'
    data[:data] = { :regions => [region] }
    data[:client] = Aws::EC2::Client
    @region = AwsRegion.new(region_name: 'eu-west-2', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_region_exists
    assert @region.exists?
  end

  def test_region_name
    assert_equal(@region.region_name, 'eu-west-2')
  end

  def test_region_endpoint
    assert_equal(@region.endpoint, 'ec2.eu-west-2.amazonaws.com')
  end
end