require "aws_backend"

class AWSEC2CapacityReservation < AwsResourceBase
  name "aws_ec2_capacity_reservation"
  desc "Describes one Capacity Reservations."
  example <<-EXAMPLE
    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { capacity_reservation_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:capacity_reservation_id])
    raise ArgumentError, "#{@__resource_name__}: capacity_reservation_id must be provided" unless opts[:capacity_reservation_id] && !opts[:capacity_reservation_id].empty?
    @display_name = opts[:capacity_reservation_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_capacity_reservations({ capacity_reservation_ids: [opts[:capacity_reservation_id]] })
      @resp = resp.capacity_reservations[0].to_h
      @capacity_reservation_id = resp.capacity_reservations[0].capacity_reservation_id
      create_resource_methods(@resp)
    end
  end

  def capacity_reservation_id
    return nil unless exists?
    @resp[:capacity_reservation_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @capacity_reservation_id
  end

  def to_s
    "Capacity Reservation Id: #{@display_name}"
  end
end
