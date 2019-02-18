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
    mock_route_table[:propagating_vgws] = []
    mock_route_table[:route_table_id] = 'rtb-ad212345'
    mock_route_table[:tags] = []
    mock_route_table[:vpc_id] = 'vpc-c2a12345'
    data[:data] = { :route_tables => [mock_route_table] }
    data[:client] = Aws::EC2::Client
    @route_tables = AwsRouteTables.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_tables_exists
    assert @route_tables.exist?
  end

  def test_route_tables_ids
    assert_equal(@route_tables.route_table_ids, ['rtb-ad212345'])
  end

  def test_route_tables_vpc_ids
    assert_equal(@route_tables.vpc_ids, ['vpc-c2a12345'])
  end

end