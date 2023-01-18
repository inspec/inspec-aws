require "aws_backend"

class AWSEC2SpotFleets < AwsResourceBase
  name "aws_ec2_spot_fleets"
  desc "Describes your Spot Fleet requests."

  example "
    describe aws_ec2_spot_fleets do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:activity_statuses, field: :activity_status)
    .register_column(:create_times, field: :create_time)
    .register_column(:spot_fleet_request_configs, field: :spot_fleet_request_config)
    .register_column(:spot_fleet_request_ids, field: :spot_fleet_request_id)
    .register_column(:spot_fleet_request_states, field: :spot_fleet_request_state)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_spot_fleet_requests(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.spot_fleet_request_configs.each do |resp|
        rows += [{ activity_status: resp.activity_status,
                   create_time: resp.create_time,
                   spot_fleet_request_config: resp.spot_fleet_request_config,
                   spot_fleet_request_id: resp.spot_fleet_request_id,
                   spot_fleet_request_state: resp.spot_fleet_request_state,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
