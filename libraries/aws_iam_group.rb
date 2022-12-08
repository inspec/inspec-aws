require "aws_backend"

class AwsIamGroup < AwsResourceBase
  name "aws_iam_group"
  desc "Verifies settings for an AWS IAM Group."

  example "
    describe aws_iam_group('group-1') do
      it { should exist }
    end
  "

  attr_reader :group_name, :users, :group_id, :arn, :inline_policy_names

  def initialize(opts = {})
    opts = { group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:group_name])

    catch_aws_errors do
      @resp = @aws.iam_client.get_group(group_name: opts[:group_name])
      group_name = { group_name: opts[:group_name] }
      iam_client = @aws.iam_client

      group       = @resp[:group]
      @group_name = group.group_name
      @group_id   = group.group_id
      @arn        = group.arn
      @users      = @resp[:users].map(&:user_name)
      @inline_policy_names = iam_client.list_group_policies(group_name).policy_names
    end
  end

  def resource_id
    @arn
  end

  def exists?
    @arn.start_with?("arn:")
  end

  def to_s
    "AWS IAM Group: #{@group_name}"
  end
end
