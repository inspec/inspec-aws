# frozen_string_literal: true

require 'aws_backend'

class AWSEC2CapacityReservation < AwsResourceBase
  name 'aws_ec2_capacity_reservation'
  desc 'Describes one or more of your Capacity Reservations.'

  example "
    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { capacity_reservation_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:capacity_reservation_id])
    raise ArgumentError, "#{@__resource_name__}: capacity_reservation_id must be provided" unless opts[:capacity_reservation_id] && !opts[:capacity_reservation_id].empty?
    @display_name = opts[:capacity_reservation_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_capacity_reservations({ capacity_reservation_ids: [opts[:capacity_reservation_id]] })
      @resp = resp.capacity_reservations[0].to_h
      create_resource_methods(@resp)
    end
  end

  def transit_gateway_attachment_id
    return nil unless exists?
    @resp[:transit_gateway_attachment_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Capacity Reservation Id: #{@display_name}"
  end
end