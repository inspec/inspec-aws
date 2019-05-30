# frozen_string_literal: true

require 'aws_backend'

class AwsRouteTable < AwsResourceBase
  name 'aws_route_table'
  desc 'Verifies settings for an AWS Route Table'
  example "
    describe aws_route_table do
      its('route_table_id') { should cmp 'rtb-05462d2278326a79c' }
    end
  "

  def initialize(opts = {})
    opts = { route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:route_table_id])

    raise ArgumentError, "#{@__resource_name__}: ID must be in the format 'rtb-' followed by 8 or 17 hexadecimal characters." if opts[:route_table_id] !~ /^rtb\-([0-9a-f]{8})|(^rtb\-[0-9a-f]{17})$/

    @display_name = opts[:route_table_id]
    filter = { name: 'route-table-id', values: [opts[:route_table_id]] }
    catch_aws_errors do
      resp = @aws.compute_client.describe_route_tables({ filters: [filter] })
      @route_table = resp.route_tables[0].to_h
      create_resource_methods(@route_table)
    end
  end

  def exists?
    !@route_table.nil? && !@route_table.empty?
  end

  def to_s
    "Route table #{@display_name}"
  end
end
