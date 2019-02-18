require 'helper'
require 'aws_regions'
require 'aws-sdk-core'

class AwsRegionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRegions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRegions.new('rubbish') }
  end

  def test_regions_non_existing_for_empty_response
    refute AwsRegions.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRegionsTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_regions
    region = {}
    region[:endpoint] = 'ec2.eu-west-2.amazonaws.com'
    region[:region_name] = 'eu-west-2'
    another_region = {}
    another_region[:endpoint] = 'blog.chef.io'
    another_region[:region_name] = 'you-should-really-read-this'
    data[:data] = { :regions => [region, another_region] }
    data[:client] = Aws::EC2::Client
    @regions = AwsRegions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_region_exists
    assert @regions.exist?
  end

  def test_region_names
    assert_equal(@regions.region_names, ['eu-west-2', 'you-should-really-read-this'])
  end

  def test_region_endpoints
    assert_equal(@regions.endpoints, ['ec2.eu-west-2.amazonaws.com', 'blog.chef.io'])
  end
end