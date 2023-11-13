require "aws_backend"

class AWSCognitoUserPoolClient < AwsResourceBase
  name "aws_cognito_userpool_client"
  desc "Client method for returning the configuration information and metadata of the specified user pool app client."
  example <<-EXAMPLE
    describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { user_pool_id: opts, client_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(user_pool_id client_id))
    catch_aws_errors do
      resp = @aws.cognitoidentityprovider_client.describe_user_pool_client({ user_pool_id: opts[:user_pool_id], client_id: opts[:client_id] })
      @user_pool_client = resp.user_pool_client.to_h
      create_resource_methods(@user_pool_client)
    end
  end

  def id
    return unless exists?
    @user_pool_client[:user_pool_id, :client_id]
  end

  def resource_id
    return @display_name unless exists?
    @user_pool_client[:client_id]
  end

  def exists?
    !@user_pool_client.nil? && !@user_pool_client.empty?
  end

  def to_s
    "User Pool ID: #{@display_name}"
  end
end
