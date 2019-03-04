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
end
