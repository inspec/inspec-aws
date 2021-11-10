# frozen_string_literal: true

require 'aws_backend'

class AWSRDSProxy < AwsResourceBase
  name 'aws_rds_db_proxy'
  desc 'Returns information about DB proxies.'

  example "
    describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(db_proxy_name))
    raise ArgumentError, "#{@__resource_name__}: db_proxy_name must be provided" unless opts[:db_proxy_name] && !opts[:db_proxy_name].empty?
    @display_name = opts[:db_proxy_name]
    catch_aws_errors do
      resp = @aws.rds_client.describe_db_proxies({ db_proxy_name: opts[:db_proxy_name] })
      @res = resp.db_proxies[0].to_h
      create_resource_methods(@res)
    end
  end

  def db_proxy_name
    return nil unless exists?
    @res[:db_proxy_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "DB Proxy Name: #{@display_name}"
  end

  def auth_description
    auth.map(&:description)
  end

  def auth_user_name
    auth.map(&:user_name)
  end

  def auth_scheme
    auth.map(&:auth_scheme)
  end

  def auth_secret_arn
    auth.map(&:secret_arn)
  end

  def auth_iam_auth
    auth.map(&:iam_auth)
  end
end
