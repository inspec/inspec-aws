require "aws_backend"

class AWSSESMaintenanceWindowTarget < AwsResourceBase
  name "aws_ssm_maintenance_window_target"
  desc "Retrieves a target in the maintenance window."

  example "
    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(window_id window_target_id))
    raise ArgumentError, "#{@__resource_name__}: window_id must be provided" unless opts[:window_id] && !opts[:window_id].empty?
    raise ArgumentError, "#{@__resource_name__}: window_target_id must be provided" unless opts[:window_target_id] && !opts[:window_target_id].empty?
    filter = [
      {
        key: "WindowTargetId",
        values: [opts[:window_target_id]],
      },
    ]
    @display_name = opts[:window_target_id]
    catch_aws_errors do
      resp = @aws.ssm_client.describe_maintenance_window_targets({ window_id: opts[:window_id], filters: filter })
      @res = resp.targets[0].to_h
      @window_id = @res[:window_id]
      @window_target_id = @res[:window_target_id]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@window_id}_#{@window_target_id}"
  end

  def window_target_id
    return unless exists?
    @res[:window_target_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def target_keys
    targets.map(&:key)
  end

  def target_values
    targets.map(&:value)
  end

  def to_s
    "Window Target Id: #{@display_name}"
  end
end
