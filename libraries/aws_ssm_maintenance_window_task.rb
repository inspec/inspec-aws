require "aws_backend"

class AWSSESMaintenanceWindowTask < AwsResourceBase
  name "aws_ssm_maintenance_window_task"
  desc "Retrieves a task in the maintenance window."

  example "
    describe aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(window_id window_task_id))
    raise ArgumentError, "#{@__resource_name__}: window_id must be provided" unless opts[:window_id] && !opts[:window_id].empty?
    raise ArgumentError, "#{@__resource_name__}: window_task_id must be provided" unless opts[:window_task_id] && !opts[:window_task_id].empty?
    filter = [
      {
        key: "WindowTaskId",
        values: [opts[:window_task_id]],
      },
    ]
    @display_name = opts[:window_task_id]
    catch_aws_errors do
      resp = @aws.ssm_client.describe_maintenance_window_tasks({ window_id: opts[:window_id], filters: filter })
      @res = resp.tasks[0].to_h
      @window_id = @res[:window_id]
      @window_task_id = @res[:window_task_id]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@window_id}_#{@window_task_id}"
  end

  def window_task_id
    return unless exists?
    @res[:window_task_id]
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
    "Window Task Id: #{@display_name}"
  end
end
