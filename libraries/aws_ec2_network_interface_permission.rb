# frozen_string_literal: true

require 'aws_backend'

class AWSEC2NetworkInterfacePermission < AwsResourceBase
  name 'aws_ec2_network_interface_permission'
  desc 'Describes one or more of your network interfaces.'

  example "
    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'network_interface_permission_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { network_interface_permission_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:network_interface_permission_id])
    raise ArgumentError, "#{@__resource_name__}: network_interface_permission_id must be provided" unless opts[:network_interface_permission_id] && !opts[:network_interface_permission_id].empty?
    @display_name = opts[:network_interface_permission_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_network_interface_permissions({ network_interface_permission_ids: [opts[:network_interface_permission_id]] })
      @res = resp.network_interface_permissions[0].to_h
      create_resource_methods(@res)
    end
  end

  def network_interface_permission_id
    return nil unless exists?
    @res[:network_interface_permission_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Network Interface Permission ID: #{@display_name}"
  end
end
