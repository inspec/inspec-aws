require 'helper'
require 'aws_route_table'
require 'aws-sdk-core'

class AwsRouteTableConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRouteTable.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRouteTable.new('rubbish') }
  end

  def test_accepts_route_table_id_as_hash_eight_sign
    AwsRouteTable.new(route_table_id: 'rtb-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_route_table_id_as_hash
    AwsRouteTable.new(route_table_id: 'rtb-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRouteTable.new(rubbish: 9) }
  end

  def test_rejects_invalid_route_table_id
    assert_raises(ArgumentError) { AwsRouteTable.new(route_table_id: 'rtb-rubbish') }
  end

  def test_route_table_non_existing
    refute AwsRouteTable.new(route_table_id: 'rtb-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRouteTableHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_route_tables
    mock_route_table = {}
    mock_route_table[:propagating_vgws] = []
    mock_route_table[:route_table_id] = 'rtb-ad212345'
    mock_route_table[:tags] = []
    mock_route_table[:vpc_id] = 'vpc-c2a12345'
    mock_route_table[:routes] = [{
      destination_cidr_block: "default",
      destination_ipv_6_cidr_block: "default",
      destination_prefix_list_id: "default",
      egress_only_internet_gateway_id: "default",
      gateway_id: "default",
      instance_id: "default",
      instance_owner_id: "default",
      nat_gateway_id: "default",
      transit_gateway_id: "default",
      local_gateway_id: "default",
      carrier_gateway_id: "default",
      network_interface_id: "default",
      origin: "default",
      state: "default",
      vpc_peering_connection_id: "default"
    }]
    mock_route_table[:associations] =  [{
                                      main: false,
                                      route_table_association_id: "rtbassoc-05dc3f4b81d9d500f",
                                      route_table_id: "rtb-083b0c200426df383",
                                      subnet_id: "subnet-026a4cbe6c04c36c2",
                                      gateway_id: nil,
                                      association_state: { state: "associated", status_message: nil } }]
    data[:data] = { :route_tables => [mock_route_table] }
    data[:client] = Aws::EC2::Client
    @route_table = AwsRouteTable.new(route_table_id: 'rtb-ad212345', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_table_exists
    assert @route_table.exists?
  end

  def test_route_table_propagating_vgws
    assert_equal(@route_table.propagating_vgws, [])
  end

  def test_route_table_route_table_id
    assert_equal(@route_table.route_table_id, 'rtb-ad212345')
  end

  def test_route_table_tags
    assert_equal(@route_table.tags, {})
  end

  def test_route_table_vpc_id
    assert_equal(@route_table.vpc_id, 'vpc-c2a12345')
  end

  def test_associated_subnet_ids
    assert_includes(@route_table.associated_subnet_ids, 'subnet-026a4cbe6c04c36c2')
  end

  def test_empty_associated_gateway_ids
    assert_empty(@route_table.associated_gateway_ids)
  end

  def test_main
    refute(@route_table.main?)
  end

  def test_has_subnet_associated
    assert(@route_table.has_subnet_associated?('subnet-026a4cbe6c04c36c2'))
  end

  def test_has_empty_gateway_associations
    refute(@route_table.has_gateway_associated?('tgw-123457876543'))
  end

  def test_has_failed_association_value
    refute(@route_table.has_failed_association_value?(subnet_id: 'subnet-026a4cbe6c04c36c2'))
  end

  def test_has_failed_association_value
    refute(@route_table.has_failed_association_value?)
  end
end
