require 'helper'
require 'aws_route_tables'
require 'aws-sdk-core'

class AwsRouteTablesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRouteTables.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRouteTables.new('rubbish') }
  end

  def test_route_tables_non_existing_for_empty_response
    refute AwsRouteTables.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRouteTablesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_route_tables
    mock_route_table = {}
    mock_route_table[:route_table_id] = 'rtb-0801bea66842eac41'
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
    @route_tables = AwsRouteTables.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_tables_exists
    assert @route_tables.exist?
  end

  def test_route_tables_ids
    assert_equal(@route_tables.route_table_ids, ['rtb-0801bea66842eac41'])
  end

  def test_route_tables_vpc_ids
    assert_equal(@route_tables.vpc_ids, ['vpc-c2a12345'])
  end

  def test_destination_cidr_blocks
    assert_equal(@route_tables.destination_cidr_blocks, ['default'])
  end

  def test_destination_ipv_6_cidr_blocks
    assert_equal(@route_tables.destination_ipv_6_cidr_blocks, ['default'])
  end

  def test_destination_prefix_list_ids
    assert_equal(@route_tables.destination_prefix_list_ids, ['default'])
  end

  def test_egress_only_internet_gateway_ids
    assert_equal(@route_tables.egress_only_internet_gateway_ids, ['default'])
  end

  def test_gateway_ids
    assert_equal(@route_tables.gateway_ids, ['default'])
  end

  def test_instance_ids
    assert_equal(@route_tables.instance_ids, ['default'])
  end

  def test_instance_owner_ids
    assert_equal(@route_tables.instance_owner_ids, ['default'])
  end

  def test_network_interface_ids
    assert_equal(@route_tables.network_interface_ids, ['default'])
  end

  def test_origins
    assert_equal(@route_tables.origins, ['default'])
  end

  def test_states
    assert_equal(@route_tables.states, ['default'])
  end

  def test_vpc_peering_connection_ids
    assert_equal(@route_tables.vpc_peering_connection_ids, ['default'])
  end

  def test_route_table_association_ids
    assert_includes(@route_tables.route_table_association_ids, 'rtbassoc-05dc3f4b81d9d500f')
  end

  def test_association_subnet_ids
    assert_includes(@route_tables.association_subnet_ids, 'subnet-026a4cbe6c04c36c2')
  end

  def test_associated_subnet_ids
    assert_includes(@route_tables.associated_subnet_ids, 'subnet-026a4cbe6c04c36c2')
  end

  def test_association_gateway_ids
    assert_empty(@route_tables.association_gateway_ids)
  end

  def test_associated_gateway_ids
    assert_empty(@route_tables.associated_gateway_ids)
  end

  def test_association_states
    assert_includes(@route_tables.association_states, 'associated')
  end
end