require 'helper'
require 'aws_ec2_transit_gateway_attachments'
require 'aws-sdk-core'

class AwsEc2TransitGatewayAttachmentsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEc2TransitGatewayAttachments.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEc2TransitGatewayAttachments.new('rubbish') }
  end

  def test_transit_gateway_attachments_non_existing_for_empty_response
    refute AwsEc2TransitGatewayAttachments.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2TransitGatewayAttachmentsPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_attachments
    mock_transitGatewayAttachments = {}
    mock_transitGatewayAttachments[:transit_gateway_attachment_id] = 'tgw-attach-006f2fd0a03d51323'
    mock_transitGatewayAttachments[:transit_gateway_id] = 'tgw-02850dffe1c3b222c'
    mock_transitGatewayAttachments[:transit_gateway_owner_id] = '112758395563'
    mock_transitGatewayAttachments[:resource_owner_id] = '112758395563'
    mock_transitGatewayAttachments[:resource_type] = 'vpc'
    mock_transitGatewayAttachments[:resource_id] = 'vpc-08b86815ee2c22d53'
    mock_transitGatewayAttachments[:state] = 'available'
    data[:data] = { :transit_gateway_attachments => [mock_transitGatewayAttachments] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_attachments = AwsEc2TransitGatewayAttachments.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_attachment_id_exists
    assert @transit_gateway_attachments.exist?
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@transit_gateway_attachments.transit_gateway_attachment_ids, ['tgw-attach-006f2fd0a03d51323'])
  end

  def test_transit_gateway_ids
    assert_equal(@transit_gateway_attachments.transit_gateway_ids, ['tgw-02850dffe1c3b222c'])
  end

  def test_transit_gateway_owner_ids
    assert_equal(@transit_gateway_attachments.transit_gateway_owner_ids, ['112758395563'])
  end

  def test_resource_owner_ids
    assert_equal(@transit_gateway_attachments.resource_owner_ids, ['112758395563'])
  end

  def test_resource_types
    assert_equal(@transit_gateway_attachments.resource_types, ['vpc'])
  end

  def test_resource_ids
    assert_equal(@transit_gateway_attachments.resource_ids, ['vpc-08b86815ee2c22d53'])
  end

  def test_states
    assert_equal(@transit_gateway_attachments.states, ['available'])
  end
end