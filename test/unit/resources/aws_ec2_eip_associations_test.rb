require 'helper'
require 'aws_ec2_eip_associations'
require 'aws-sdk-core'

class AwsEIPsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2EIPAssociations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2EIPAssociations.new('rubbish') }
  end

  def test_addresses_non_existing_for_empty_response
    refute AWSEC2EIPAssociations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2EIPAssociationsHappyPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_addresses
    mock_data = {}
    mock_data[:association_id] = 'test1'
    data[:data] = { addresses: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2EIPAssociations.new(client_args: { stub_responses: true }, stub_data: [data])
    end

  def test_association_ids
    assert_equal(@resp.association_ids, ['test1'])
  end
end