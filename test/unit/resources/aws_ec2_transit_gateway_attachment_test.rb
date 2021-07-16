require 'helper'
require 'aws_ec2_transit_gateway_attachment'
require 'aws-sdk-core'

class AwsEc2TransitGatewayAttachmentConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2TransitGatewayAttachment.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_transit_gateway_attachment_id_as_hash_eight_sign
    AwsEc2TransitGatewayAttachment.new(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323', client_args: { stub_responses: true })
  end

  def test_accepts_transit_gateway_attachment_id_as_hash
    AwsEc2TransitGatewayAttachment.new(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2TransitGatewayAttachment.new(rubbish: 9) }
  end
end

class AwsEc2TransitGatewayAttachmentPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_attachments
    mock_transit_gateway_attachment = {}
    mock_transit_gateway_attachment[:transit_gateway_attachment_id] = 'tgw-attach-006f2fd0a03d51323'
    mock_transit_gateway_attachment[:transit_gateway_id] = 'tgw-02850dffe1c3b222c'
    mock_transit_gateway_attachment[:transit_gateway_owner_id] = '112758395563'
    mock_transit_gateway_attachment[:resource_owner_id] = '112758395563'
    mock_transit_gateway_attachment[:resource_type] = 'vpc'
    mock_transit_gateway_attachment[:resource_id] = 'vpc-08b86815ee2c22d53'
    mock_transit_gateway_attachment[:state] = 'available'
    data[:data] = { :transit_gateway_attachments => [mock_transit_gateway_attachment] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_attachments = AwsEc2TransitGatewayAttachment.new(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_attachment_transit_gateway_attachment_id_exists
    assert @transit_gateway_attachments.exists?
  end

  def test_transit_gateway_attachment_transit_gateway_attachment_id_available
    assert @transit_gateway_attachments.available?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@transit_gateway_attachments.transit_gateway_attachment_id, 'tgw-attach-006f2fd0a03d51323')
  end

  def test_transit_gateway_id
    assert_equal(@transit_gateway_attachments.transit_gateway_id, 'tgw-02850dffe1c3b222c')
  end

  def test_transit_gateway_owner_id
    assert_equal(@transit_gateway_attachments.transit_gateway_owner_id, '112758395563')
  end

  def test_resource_owner_id
    assert_equal(@transit_gateway_attachments.resource_owner_id, '112758395563')
  end

  def test_resource_type
    assert_equal(@transit_gateway_attachments.resource_type, 'vpc')
  end

  def test_resource_id
    assert_equal(@transit_gateway_attachments.resource_id, 'vpc-08b86815ee2c22d53')
  end

  def test_state
    assert_equal(@transit_gateway_attachments.state, 'available')
  end
end