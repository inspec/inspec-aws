require "aws_backend"

class AWSEc2TrafficMirrorTargets < AwsResourceBase
  name "aws_ec2_traffic_mirror_targets"
  desc "Verifies settings for a collection of AWS EC2 Traffic Mirror targets"

  example "
    describe aws_ec2_traffic_mirror_targets do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:traffic_mirror_target_ids, field: :traffic_mirror_target_id)
    .register_column(:network_interface_ids, field: :network_interface_id)
    .register_column(:network_load_balancer_arns, field: :network_load_balancer_arn)
    .register_column(:types, field: :type)
    .register_column(:descriptions, field: :description)
    .register_column(:owner_ids, field: :owner_id)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    traffic_mirror_targets_rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_traffic_mirror_targets(pagination_options)
      end
      return traffic_mirror_targets_rows if !@api_response || @api_response.empty?

      @api_response.traffic_mirror_targets.each do |traffic_mirror_targets|
        traffic_mirror_targets_rows += [{ traffic_mirror_target_id: traffic_mirror_targets.traffic_mirror_target_id,
                                          network_interface_id: traffic_mirror_targets.network_interface_id,
                                          network_load_balancer_arn: traffic_mirror_targets.network_load_balancer_arn,
                                          type: traffic_mirror_targets.type,
                                          description: traffic_mirror_targets.description,
                                          owner_id: traffic_mirror_targets.owner_id,
                                          tags: traffic_mirror_targets.tags }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = traffic_mirror_targets_rows
  end
end
