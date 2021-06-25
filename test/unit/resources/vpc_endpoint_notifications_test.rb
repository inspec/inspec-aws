require 'helper'
require 'aws_vpc_endpoint_connection_notifications'
require 'aws-sdk-core'

class AwsVPCEndpointConnectionNotificationConstructorTest < Minitest::Test

    def test_empty_params_ok
      AwsVpcEndpointConnectionNotifications.new(client_args: { stub_responses: true })
    end

    def test_rejects_scalar_invalid_args
      assert_raises(ArgumentError) { AwsVpcEndpointConnectionNotifications.new('rubbish') }
    end


end


class AwsVpcEndpointConnectionNotificationsHappyPathTest < Minitest::Test

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
    @vpcen = AwsVpcEndpointConnectionNotifications.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpce_exists
    assert @vpcen.exists?
  end

  def test_vpcen_endpoint_notification_id
    assert_equal(@vpcen.connection_notification_ids, ['vpce-nfn-03ad3532a5c71f8af'])
  end

  def test_vpcn_endpoint_type
    assert_equal(@vpcen.service_ids, ['vpce-svc-04deb776dc2b8e67f'])
  end


  def test_service_name
    assert_equal(@vpcen.connection_notification_arns, ['arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju'])
  end

  def test_vpcen_state
    assert_equal(@vpcen.connection_notification_state, ['Enabled'])

  end

end
