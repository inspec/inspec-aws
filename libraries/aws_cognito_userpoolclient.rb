# frozen_string_literal: true

require 'aws_backend'

class AWSCognitoUserPoolClient < AwsResourceBase
  name 'aws_cognito_userpoolclient'
  desc 'Client method for returning the configuration information and metadata of the specified user pool app client.'

  example `
    describe aws_cognito_userpoolclient(job_queue_name: 'test1') do
      it { should exist }
    end
  `

  def initialize(opts = {})
    opts = { job_queue_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:job_queue_name])

    raise ArgumentError, "#{@__resource_name__}: job_queue_name must be provided" unless opts[:job_queue_name] && !opts[:job_queue_name].empty?
    @display_name = opts[:job_queue_name]
    catch_aws_errors do
      resp = @aws.cognitoidentityprovider_client.describe_user_pool_client({ job_queues: [opts[:job_queue_name]] })
      @job_queues = resp.job_queues[0].to_h
      create_resource_methods(@job_queues)
    end
  end

  def id
    return nil unless exists?
    @job_queues[:job_queue_name]
  end

  def exists?
    !@job_queues.nil? && !@job_queues.empty?
  end

  def encrypted?
    @job_queues[:encrypted]
  end

  def to_s
    "Job Queue Name: #{@display_name}"
  end
end
