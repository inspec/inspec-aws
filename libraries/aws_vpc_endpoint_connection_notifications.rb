require 'aws_backend'

class AwsVpcEndpointConnectionNotifications < AwsResourceBase
  name 'aws_vpc_endpoint_connection_notifications'
  desc 'Verifies settings for all the AWS VPC Endpoint Notifications.'

  example "
    describe aws_vpc_endpoint_connection_notifications do
      it { should exist }
    end
  "

  attr_reader :table

  # FilterTable setup
  FilterTable.create
             .register_column(:connection_notification_ids,        field: :connection_notification_id)
             .register_column(:service_ids,                        field: :service_id)
             .register_column(:connection_notification_types,      field: :connection_notification_type)
             .register_column(:connection_notification_arns,       field: :connection_notification_arn)
             .register_column(:connection_events,                  field: :connection_events)
             .register_column(:connection_notification_state,      field: :connection_notification_state)
             .register_column(:vpc_endpoint_id,                    field: :vpc_endpoint_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    vpcen_rows = []
    catch_aws_errors do
      @vpcens = @aws.compute_client.describe_vpc_endpoint_connection_notifications
    end
    return vpcen_rows if !@vpcens || @vpcens.empty?
    @vpcens.connection_notification_set.each do |vpcen|
      vpcen_rows+=[{ connection_notification_id: vpcen[:connection_notification_id],
                     service_id: vpcen[:service_id],
                     connection_notification_type: vpcen[:connection_notification_type],
                     connection_notification_arn: vpcen[:connection_notification_arn],
                     connection_events: vpcen[:connection_events],
                     connection_notification_state: vpcen[:connection_notification_state],
                     vpc_endpoint_id: vpcen[:vpc_endpoint_id] }]
    end
    @table = vpcen_rows
  end
end
