require "aws_backend"

class AWSEC2CapacityReservations < AwsResourceBase
  name "aws_ec2_capacity_reservations"
  desc "Describes one or more of your Capacity Reservations."

  example "
    describe aws_ec2_capacity_reservations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:capacity_reservation_ids, field: :capacity_reservation_id)
    .register_column(:owner_ids, field: :owner_id)
    .register_column(:capacity_reservation_arns, field: :capacity_reservation_arn)
    .register_column(:availability_zone_ids, field: :availability_zone_id)
    .register_column(:instance_types, field: :instance_type)
    .register_column(:instance_platforms, field: :instance_platform)
    .register_column(:availability_zones, field: :availability_zone)
    .register_column(:tenancies, field: :tenancy)
    .register_column(:total_instance_counts, field: :total_instance_count)
    .register_column(:available_instance_counts, field: :available_instance_count)
    .register_column(:ebs_optimized, field: :ebs_optimized)
    .register_column(:ephemeral_storages, field: :ephemeral_storage)
    .register_column(:states, field: :state)
    .register_column(:start_dates, field: :start_date)
    .register_column(:end_dates, field: :end_date)
    .register_column(:end_date_types, field: :end_date_type)
    .register_column(:instance_match_criterias, field: :instance_match_criteria)
    .register_column(:create_dates, field: :create_date)
    .register_column(:tags, field: :tags)
    .register_column(:outpost_arns, field: :outpost_arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_capacity_reservations(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.capacity_reservations.each do |res|
        rows += [{ capacity_reservation_id: res.capacity_reservation_id,
                   owner_id: res.owner_id,
                   capacity_reservation_arn: res.capacity_reservation_arn,
                   availability_zone_id: res.availability_zone_id,
                   instance_type: res.instance_type,
                   instance_platform: res.instance_platform,
                   availability_zone: res.availability_zone,
                   tenancy: res.tenancy,
                   total_instance_count: res.total_instance_count,
                   available_instance_count: res.available_instance_count,
                   ebs_optimized: res.ebs_optimized,
                   ephemeral_storage: res.ephemeral_storage,
                   state: res.state,
                   start_date: res.start_date,
                   end_date: res.end_date,
                   end_date_type: res.end_date_type,
                   instance_match_criteria: res.instance_match_criteria,
                   create_date: res.create_date,
                   tags: res.tags,
                   outpost_arn: res.outpost_arn }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end
