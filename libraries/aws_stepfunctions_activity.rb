require "aws_backend"

class AWSStepFunctionsActivity < AwsResourceBase
  name "aws_stepfunctions_activity"
  desc "Describes an activity."

  example "
    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(activity_arn))
    raise ArgumentError, "#{@__resource_name__}: activity_arn must be provided" unless opts[:activity_arn] && !opts[:activity_arn].empty?
    @display_name = opts[:activity_arn]
    catch_aws_errors do
      resp = @aws.states_client.describe_activity({ activity_arn: opts[:activity_arn] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def activity_arn
    return nil unless exists?
    @res[:activity_arn]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Activity ARN: #{@display_name}"
  end
end
