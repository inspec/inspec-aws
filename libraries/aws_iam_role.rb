# frozen_string_literal: true

class AwsIamRole < AwsResourceBase
  name 'aws_iam_role'
  desc 'Verifies settings for an IAM Role.'
  example "
    describe aws_iam_role('my-role') do
      it { should exist }
    end
  "

  attr_reader :path, :role_name, :role_id, :arn, :create_date,
              :assume_role_policy_document, :description, :max_session_duration,
              :permissions_boundary_type, :permissions_boundary_arn, :attached_policy_names,
              :attached_policy_arns

  def initialize(opts = {})
    opts = { role_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:role_name])

    catch_aws_errors do
      resp = @aws.iam_client.get_role(role_name: opts[:role_name]).role

      @role_name    = resp.role_name
      @role_id      = resp.role_id
      @arn          = resp.arn
      @description  = resp.description
      @create_date  = resp.create_date
      @path         = resp.path
      @assume_role_policy_document = resp.assume_role_policy_document
      @max_session_duration        = resp.max_session_duration
      @permissions_boundary_type   = nil
      @permissions_boundary_arn    = nil
      if resp.permissions_boundary
        @permissions_boundary_type = resp.permissions_boundary.permissions_boundary_type
        @permissions_boundary_arn  = resp.permissions_boundary.permissions_boundary_arn
      end
      fetch_attached_role_policies!
    end
  end

  def inline_policies
    return @inline_policies if defined? @inline_policies
    catch_aws_errors do
      resp = @aws.iam_client.list_role_policies({ role_name: @role_name })
      @inline_policies = resp.policy_names
    end
  end

  def tags
    tag_list = []
    catch_aws_errors do
      tag_list = @aws.iam_client.get_role(role_name: opts[:role_name]).role.tags
    end
    map_tags(tag_list)
  end

  def resource_id
    @arn
  end

  def exists?
    !@arn.nil?
  end

  def to_s
    "AWS IAM Role #{@role_name}"
  end

  private

  def fetch_attached_role_policies!
    catch_aws_errors do
      resp = @aws.iam_client.list_attached_role_policies({ role_name: @role_name }).attached_policies
      @attached_policy_names = []
      @attached_policy_arns  = []
      unless resp.empty?
        resp.each do |r|
          @attached_policy_names << r.policy_name
          @attached_policy_arns  << r.policy_arn
        end
      end
    end
  end
end
