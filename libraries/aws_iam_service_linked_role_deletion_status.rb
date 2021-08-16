# frozen_string_literal: true

require 'aws_backend'

class AWSIAMServiceLinkedRoleDeletionStatus < AwsResourceBase
  name 'aws_iam_service_linked_role_deletion_status'
  desc 'Retrieves the status of your service-linked role deletion.'

  example "
    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { deletion_task_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:deletion_task_id])
    raise ArgumentError, "#{@__resource_name__}: deletion_task_id must be provided" unless opts[:deletion_task_id] && !opts[:deletion_task_id].empty?
    @display_name = opts[:deletion_task_id]
    catch_aws_errors do
      resp = @aws.iam_client.get_instance_profile({ deletion_task_id: opts[:deletion_task_id] })
      @res = resp.instance_profile.to_h
      create_resource_methods(@res)
    end
  end

  def deletion_task_id
    return nil unless exists?
    @res[:deletion_task_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "deletion_task_id: #{@display_name}"
  end
end

