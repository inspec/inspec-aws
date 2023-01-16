require "aws_backend"

class AWSStepFunctionsStateMachine < AwsResourceBase
  name "aws_stepfunctions_state_machine"
  desc "Describes a state machine."

  example "
    describe aws_stepfunctions_state_machine(state_machine_arn: 'state_machine_arn_value') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { state_machine_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(state_machine_arn))
    raise ArgumentError, "#{@__resource_name__}: state_machine_arn must be provided" unless opts[:state_machine_arn] && !opts[:state_machine_arn].empty?
    @display_name = opts[:state_machine_arn]
    catch_aws_errors do
      resp = @aws.states_client.describe_state_machine({ state_machine_arn: opts[:state_machine_arn] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def state_machine_arn
    return nil unless exists?
    @res[:state_machine_arn]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "State Machine ARN: #{@display_name}"
  end
end
