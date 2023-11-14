require "aws_backend"

class AWSSESMaintenanceWindow < AwsResourceBase
  name "aws_ssm_maintenance_window"
  desc "Retrieves a maintenance window."

  example "
    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[window_id])
    unless opts[:window_id] && !opts[:window_id].empty?
      raise ArgumentError, "#{@__resource_name__}: window_id must be provided"
    end
    @display_name = opts[:window_id]
    catch_aws_errors do
      resp =
        @aws.ssm_client.get_maintenance_window({ window_id: opts[:window_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res ? @res[:window_id] : @display_name
  end

  def window_id
    return nil unless exists?
    @res[:window_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Window Id: #{@display_name}"
  end
end
