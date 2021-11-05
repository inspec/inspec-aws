# frozen_string_literal: true

require 'aws_backend'

class AWSEC2NetworkInterfacePermissions < AwsResourceBase
  name 'aws_ec2_network_interfaces_permissions'
  desc 'List all the network interface permission.'

  example "
    describe aws_ec2_network_interfaces_permissions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:network_interface_permission_ids, field: :network_interface_permission_id)
             .register_column(:network_interface_ids, field: :network_interface_id)
             .register_column(:aws_account_ids, field: :aws_account_id)
             .register_column(:aws_services, field: :aws_service)
             .register_column(:states, field: :state)
             .register_column(:status_messages, field: :status_message)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_network_interface_permissions(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.network_interface_permissions.each do |resp|
        rows += [{ network_interface_permission_id: resp.network_interface_permission_id,
                   network_interface_id: resp.network_interface_id,
                   aws_account_id: resp.aws_account_id,
                   aws_service: resp.aws_service,
                   state: resp.permission_state.state,
                   status_message: resp.permission_state.status_message }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
