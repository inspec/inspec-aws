require 'aws_backend'

class AWSNetworkManagerGlobalNetwork < AwsResourceBase
  name 'aws_network_manager_global_network'
  desc 'Describes one or more global networks.'

  example "
    describe aws_network_manager_global_network(global_network_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { global_network_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:global_network_id])
    raise ArgumentError, "#{@__resource_name__}: global_network_id must be provided" unless opts[:global_network_id] && !opts[:global_network_id].empty?
    @display_name = opts[:global_network_id]
    catch_aws_errors do
      resp = @aws.network_manager_client.describe_global_networks({ global_network_ids: [opts[:global_network_id]] })
      @res = resp.global_networks[0].to_h
      create_resource_methods(@res)
    end
  end

  def global_network_id
    return unless exists?
    @res[:global_network_id]
  end

  def resource_id
    @res? @res[:global_network_id]: @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Global Network ID: #{@display_name}"
  end
end
