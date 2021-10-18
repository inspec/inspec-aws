# frozen_string_literal: true

require 'aws_backend'

class AWSSSOAssignment < AwsResourceBase
  name 'aws_sso_assignment_deletion_request'
  desc 'Retrieves sso assignment.'

  example "
    describe aws_sso_assignment_deletion_request(window_id: 'WINDOW_ID', account_assignment_deletion_request_id: 'ACCOUNT_ASSIGNMENT_DELETION_REQUEST_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(window_id account_assignment_deletion_request_id))
    raise ArgumentError, "#{@__resource_name__}: window_id must be provided" unless opts[:window_id] && !opts[:window_id].empty?
    raise ArgumentError, "#{@__resource_name__}: account_assignment_deletion_request_id must be provided" unless opts[:account_assignment_deletion_request_id] && !opts[:account_assignment_deletion_request_id].empty?
    @display_name = opts[:account_assignment_deletion_request_id]
    catch_aws_errors do
      resp = @aws.sso_client.describe_account_assignment_deletion_status({ window_id: opts[:window_id], account_assignment_deletion_request_id: opts[:account_assignment_deletion_request_id] })
      @res = resp.account_assignment_deletion_status.to_h
      create_resource_methods(@res)
    end
  end

  def account_assignment_deletion_request_id
    return nil unless exists?
    @res[:account_assignment_deletion_request_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Account Assignment Deletion Request Id: #{@display_name}"
  end
end
