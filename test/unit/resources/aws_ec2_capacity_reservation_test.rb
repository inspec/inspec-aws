require 'helper'
require 'aws_ec2_capacity_reservation'
require 'aws-sdk-core'

class AWSEC2CapacityReservationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2CapacityReservation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2CapacityReservation.new(capacity_reservation_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2CapacityReservation.new(unexpected: 9) }
  end
end

class AWSEC2CapacityReservationSuccessPathTest < Minitest::Test

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
    data[:data] = { capacity_reservations: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2CapacityReservation.new(capacity_reservation_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_capacity_reservations_exists
    assert @resp.exists?
  end

  def test_capacity_reservation_id
    assert_equal(@resp.capacity_reservation_id, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_capacity_reservation_arn
    assert_equal(@resp.capacity_reservation_arn, 'test1')
  end

  def test_instance_type
    assert_equal(@resp.instance_type, 'test1')
  end

  def test_instance_platform
    assert_equal(@resp.instance_platform, 'test1')
  end

  def test_availability_zone
    assert_equal(@resp.availability_zone, 'test1')
  end

  def test_tenancy
    assert_equal(@resp.tenancy, 'test1')
  end

  def test_total_instance_count
    assert_equal(@resp.total_instance_count, 1)
  end

  def test_available_instance_count
    assert_equal(@resp.available_instance_count, 1)
  end

  def test_ebs_optimized
    assert_equal(@resp.ebs_optimized, true)
  end

  def test_ephemeral_storage
    assert_equal(@resp.ephemeral_storage, true)
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_start_date
    assert_equal(@resp.start_date, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end

  def test_end_date
    assert_equal(@resp.end_date, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end

  def test_end_date_type
    assert_equal(@resp.end_date_type, 'test1')
  end

  def test_instance_match_criteria
    assert_equal(@resp.instance_match_criteria, 'test1')
  end

  def test_create_date
    assert_equal(@resp.create_date, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end

  def test_outpost_arn
    assert_equal(@resp.outpost_arn, 'test1')
  end
end
