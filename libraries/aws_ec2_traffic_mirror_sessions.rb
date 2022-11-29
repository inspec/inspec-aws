require 'aws_backend'

class AWSEc2TrafficMirrorSessions < AwsResourceBase
  name 'aws_ec2_traffic_mirror_sessions'
  desc 'Verifies settings for a collection of AWS EC2 Traffic Mirror Sessions.'

  example "
    describe aws_ec2_traffic_mirror_sessions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:traffic_mirror_session_ids, field: :traffic_mirror_session_id)
             .register_column(:traffic_mirror_target_ids, field: :traffic_mirror_target_id)
             .register_column(:descriptions, field: :description)
             .register_column(:traffic_mirror_filter_ids, field: :traffic_mirror_filter_id)
             .register_column(:network_interface_ids, field: :network_interface_id)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:packet_lengths, field: :packet_length)
             .register_column(:session_numbers, field: :session_number)
             .register_column(:virtual_network_ids, field: :virtual_network_id)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    traffic_mirror_sessions_rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_traffic_mirror_sessions(pagination_options)
      end
      return traffic_mirror_sessions_rows if !@api_response || @api_response.empty?
      @api_response.traffic_mirror_sessions.each do |traffic_mirror_sessions|
        traffic_mirror_sessions_rows += [{ description: traffic_mirror_sessions.description,
          traffic_mirror_target_id: traffic_mirror_sessions.traffic_mirror_target_id,
          network_interface_id: traffic_mirror_sessions.network_interface_id,
          traffic_mirror_filter_id: traffic_mirror_sessions.traffic_mirror_filter_id,
          owner_id: traffic_mirror_sessions.owner_id,
          packet_length: traffic_mirror_sessions.packet_length,
          session_number: traffic_mirror_sessions.session_number,
          virtual_network_id: traffic_mirror_sessions.virtual_network_id,
          traffic_mirror_session_id: traffic_mirror_sessions.traffic_mirror_session_id,
          tags: traffic_mirror_sessions.tags }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end

    @table = traffic_mirror_sessions_rows
  end
end
