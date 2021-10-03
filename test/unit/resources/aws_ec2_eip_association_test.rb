require 'helper'
require 'aws_ec2_eip_association'
require 'aws-sdk-core'

class AwsEIPConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2EIPAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2EIPAssociation.new(rubbish: 9) }
  end
end

class AWSEC2EIPAssociationHappyPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_addresses
    mock_data = {}
    mock_data[:association_id] = 'test1'
    data[:data] = { addresses: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2EIPAssociation.new(association_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_association_id
    assert_equal(@resp.association_id, 'test1')
  end
end
