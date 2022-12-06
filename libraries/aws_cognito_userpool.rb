require 'aws_backend'

class AWSCognitoUserPool < AwsResourceBase
  name 'aws_cognito_userpool'
  desc 'Returns the configuration information and metadata of the specified user pool.'

  example "
    describe aws_cognito_userpool(user_pool_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { user_pool_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:user_pool_id])

    raise ArgumentError, "#{@__resource_name__}: user_pool_id must be provided" unless opts[:user_pool_id] && !opts[:user_pool_id].empty?
    @display_name = opts[:user_pool_id]
    catch_aws_errors do
      resp = @aws.cognitoidentityprovider_client.describe_user_pool({ user_pool_id: opts[:user_pool_id] })
      @user_pool = resp.user_pool.to_h
      create_resource_methods(@user_pool)
    end
  end

  def job_queue_name
    return nil unless exists?
    @user_pool[:job_queue_name]
  end

  def exists?
    !@user_pool.nil? && !@user_pool.empty?
  end

  def resource_id
    @display_name
  end

  def to_s
    "Job Queue Name: #{@display_name}"
  end
end
