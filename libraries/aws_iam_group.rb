# frozen_string_literal: true

require 'aws_backend'

class AwsIamGroup < AwsResourceBase
  name 'aws_iam_group'
  desc 'Verifies settings for an AWS IAM Group'

  example "
    describe aws_iam_group('group-1') do
      it { should exist }
    end
  "

  attr_reader :group_name, :users, :group_id, :arn

  def initialize(opts = {})
    opts = { group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:group_name])

    catch_aws_errors do
      @resp = @aws.iam_client.get_group(group_name: opts[:group_name])

      group       = @resp[:group]
      @group_name = group.group_name
      @group_id   = group.group_id
      @arn        = group.arn
      @users      = @resp[:users].map(&:user_name)
    end
  end

  def exists?
    @arn.start_with?('arn:')
  end

  def to_s
    "AWS Iam Group #{@group_name}"
  end
end
