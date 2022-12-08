require "aws_backend"

class AwsRouteTable < AwsResourceBase
  name "aws_route_table"
  desc "Verifies settings for an AWS Route Table."
  example "
    describe aws_route_table(route_table_id: 'rtb-05462d2278326a79c') do
      its('route_table_id') { should cmp 'rtb-05462d2278326a79c' }
    end

    describe aws_route_table('rtb-05462d2278326a79c') do
      its('route_table_id') { should cmp 'rtb-05462d2278326a79c' }
    end
  "

  ASSOCIATION_STATES = {
    associated: "associated",
    failed: "failed",
    disassociated: "disassociated",
  }.freeze

  def initialize(opts = {})
    opts = { route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:route_table_id])

    raise ArgumentError, "#{@__resource_name__}: ID must be in the format 'rtb-' followed by 8 or 17 hexadecimal characters." if opts[:route_table_id] !~ /^rtb\-([0-9a-f]{8})|(^rtb\-[0-9a-f]{17})$/

    @display_name = opts[:route_table_id]
    filter = { name: "route-table-id", values: [opts[:route_table_id]] }
    catch_aws_errors do
      resp = @aws.compute_client.describe_route_tables({ filters: [filter] })
      @route_table = resp.route_tables.first
      create_resource_methods(@route_table.to_h)
    end
  end

  def associated_subnet_ids
    @associated_subnet_ids ||= compact(associates.map(&:subnet_id))
  end

  def associated_gateway_ids
    compact(associates.map(&:gateway_id))
  end

  # matchers
  def exists?
    !failed_resource? && !@route_table.nil? && !@route_table.empty?
  end

  # all assoc are for the same route table ID hence we can check if either one of the route table is main
  def main?
    associates.any?(&:main)
  end

  def has_subnet_associated?(subnet_id)
    associated_subnet_ids.any? { |associated_subnet_id| associated_subnet_id == subnet_id }
  end

  def has_gateway_associated?(gateway_id)
    associated_gateway_ids.any? { |associated_gateway_id| associated_gateway_id == gateway_id }
  end

  def has_failed_association_value?(subnet_id: nil, gateway_id: nil, route_table_association_id: nil)
    !failed_associations.empty? unless subnet_id || gateway_id || route_table_association_id

    failed_associations.any? { |association|
      (subnet_id && association.subnet_id == subnet_id) || (gateway_id && association.gateway_id == gateway_id) ||
        (route_table_association_id && association.route_table_association_id == route_table_association_id)
    }
  end

  def resource_id
    @route_table ? @route_table[:route_table_id] : @display_name
  end

  def to_s
    "Route table #{@display_name}"
  end

  private

  def associations
    @route_table&.associations || []
  end

  def associates
    associations.select { |association| association.association_state.state == ASSOCIATION_STATES[:associated] }
  end

  def failed_associations
    associations.select { |association| association.association_state.state == ASSOCIATION_STATES[:failed] }
  end

  # this is to handle NullResponse objects in collection
  def compact(collection)
    # NullResponse returns `nil?` as true so the `||` is just a fallback
    collection.reject { |obj| obj.nil? || obj.is_a?(NullResponse) }
  end
end
