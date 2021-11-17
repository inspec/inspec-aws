require 'helper'
require 'aws_ec2_capacity_reservations'
require 'aws-sdk-core'

class AWSEC2CapacityReservationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2CapacityReservations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2CapacityReservations.new('rubbish') }
  end

  def test_capacity_reservations_non_existing_for_empty_response
    refute AWSEC2CapacityReservations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2CapacityReservationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_capacity_reservations
    mock_data = {}
    mock_data[:capacity_reservation_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:capacity_reservation_arn] = 'test1'
    mock_data[:instance_type] = 'test1'
    mock_data[:instance_platform] = 'test1'
    mock_data[:availability_zone] = 'test1'
    mock_data[:tenancy] = 'test1'
    mock_data[:total_instance_count] = 1
    mock_data[:available_instance_count] = 1
    mock_data[:ebs_optimized] = true
    mock_data[:ephemeral_storage] = true
    mock_data[:state] = 'test1'
    mock_data[:start_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:end_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:end_date_type] = 'test1'
    mock_data[:instance_match_criteria] = 'test1'
    mock_data[:create_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:tags] = []
    mock_data[:outpost_arn] = 'test1'
    data[:data] = { :capacity_reservations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2CapacityReservations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_capacity_reservation_ids
    assert_equal(@resp.capacity_reservation_ids, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_capacity_reservation_arns
    assert_equal(@resp.capacity_reservation_arns, ['test1'])
  end

  def test_instance_types
    assert_equal(@resp.instance_types, ['test1'])
  end

  def test_instance_platforms
    assert_equal(@resp.instance_platforms, ['test1'])
  end

  def test_availability_zones
    assert_equal(@resp.availability_zones, ['test1'])
  end

  def test_tenancies
    assert_equal(@resp.tenancies, ['test1'])
  end

  def test_total_instance_counts
    assert_equal(@resp.total_instance_counts, [1])
  end

  def test_available_instance_counts
    assert_equal(@resp.available_instance_counts, [1])
  end

  def test_ebs_optimized
    assert_equal(@resp.ebs_optimized, [true])
  end

  def test_ephemeral_storages
    assert_equal(@resp.ephemeral_storages, [true])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_start_dates
    assert_equal(@resp.start_dates, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_end_dates
    assert_equal(@resp.end_dates, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_end_date_types
    assert_equal(@resp.end_date_types, ['test1'])
  end

  def test_instance_match_criterias
    assert_equal(@resp.instance_match_criterias, ['test1'])
  end

  def test_create_dates
    assert_equal(@resp.create_dates, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end

  def test_outpost_arns
    assert_equal(@resp.outpost_arns, ['test1'])
  end
end
