require "aws_backend"

class AwsIamManagedPolicy < AwsResourceBase
  name "aws_iam_managed_policy"
  desc "Verifies settings for an Iam Policy."

  example "
    describe aws_iam_managed_policy(policy_arn: 'PolicyARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { policy_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:policy_arn])
    raise ArgumentError, "#{@__resource_name__}: policy_arn must be provided" unless opts[:policy_arn] && !opts[:policy_arn].empty?
    @display_name = opts[:policy_arn]
    catch_aws_errors do
      resp = @aws.iam_client.get_policy({ policy_arn: opts[:policy_arn] })
      @res = resp.policy.to_h
      @arn = @res[:arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @arn
  end

  def is_attachable?
    @res.is_attachable
  end

  def exists?
    !@res.nil?
  end

  def to_s
    "AWS IAM Managed Policy ARN : #{@policy_arn}"
  end
end
