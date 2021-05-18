require 'helper'
require 'aws_vpc_endpoint_connection_notification'
require 'aws-sdk-core'

class AwsVPCEndpointConnectionNotificationConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVpcEndpointConnectionNotification.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsVpcEndpointConnectionNotification.new('rubbish') }
  end

  def test_accepts_vpc_endpoint_notification_id_as_hash_eight_sign
    AwsVpcEndpointConnectionNotification.new(connection_notification_id: 'vpce-nfn-03ad3532', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_endpoint_notification_id_as_hash
    AwsVpcEndpointConnectionNotification.new(connection_notification_id: 'vpce-nfn-03ad3532a5c71f8af', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsVpcEndpointConnectionNotification.new(rubbish: 9) }
  end

  def test_rejects_invalid_vpc_endpoint_notification_id
    assert_raises(ArgumentError) { AwsVpcEndpointConnectionNotification.new(connection_notification_id: 'vpce-rubbish') }
  end

  def test_vpcn_non_existing
    refute AwsVpcEndpointConnectionNotification.new(connection_notification_id: 'vpce-nfn-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsVpcEndpointConnectionNotificationHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpc_endpoint_connection_notifications
    mock_vpc_endpoint_notifiaction = {}
    mock_vpc_endpoint_notifiaction[:connection_notification_id] = 'vpce-nfn-03ad3532a5c71f8af'
    mock_vpc_endpoint_notifiaction[:service_id] = 'vpce-svc-04deb776dc2b8e67f'
    mock_vpc_endpoint_notifiaction[:vpc_endpoint_id] = 'vpce-abcdef123456abcde'
    mock_vpc_endpoint_notifiaction[:connection_notification_arn] = 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju'
    mock_vpc_endpoint_notifiaction[:connection_events] = ['Reject']
    mock_vpc_endpoint_notifiaction[:connection_notification_state] = "Enabled"
    data[:data] = { :connection_notification_set => [mock_vpc_endpoint_notifiaction] }
    data[:client] = Aws::EC2::Client
    @vpcen = AwsVpcEndpointConnectionNotification.new(connection_notification_id: 'vpce-nfn-03ad3532a5c71f8af',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpce_exists
    assert @vpcen.exists?
  end


  def test_vpcen_endpoint_notification_id
    assert_equal(@vpcen.connection_notification_id, 'vpce-nfn-03ad3532a5c71f8af')
  end

  def test_vpc_endpoint_type
    assert_equal(@vpcen.service_id, 'vpce-svc-04deb776dc2b8e67f')
  end

  def test_vpcen_id
    assert_equal(@vpcen.vpc_endpoint_id, 'vpce-abcdef123456abcde')
  end

  def test_service_name
    assert_equal(@vpcen.connection_notification_arn, 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju')
  end

  def test_vpcen_state
    assert_equal(@vpcen.connection_notification_state, 'Enabled')

  end
end
