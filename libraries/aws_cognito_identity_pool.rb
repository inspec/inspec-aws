require 'aws_backend'

class AWSCognitoIdentityPool < AwsResourceBase
  name 'aws_cognito_identity_pool'
  desc 'Gets details about a particular identity pool, including the pool name, ID description, creation date, and current number of users.'
  example <<-EXAMPLE
    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTIRY_POOL_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { identity_pool_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:identity_pool_id])
    raise ArgumentError, "#{@__resource_name__}: identity_pool_id must be provided" unless opts[:identity_pool_id] && !opts[:identity_pool_id].empty?
    @display_name = opts[:identity_pool_id]
    catch_aws_errors do
      resp = @aws.cognitoidentity_client.describe_identity_pool({ identity_pool_id: opts[:identity_pool_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def identity_pool_id
    return unless exists?
    @res[:identity_pool_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Identity Pool ID: #{@display_name}"
  end
end
