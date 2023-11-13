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
      resp = @aws.iam_client.get_service_linked_role_deletion_status({ deletion_task_id: opts[:deletion_task_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def status
    return unless exists?
    @res[:status]
  end

  def resource_id
    @res? @display_name: ''
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Deletion Task ID: #{@display_name}"
  end
end
