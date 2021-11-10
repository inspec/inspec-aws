# frozen_string_literal: true

require 'aws_backend'

class AWSRDSProxyTargetGroup < AwsResourceBase
  name 'aws_rds_db_proxy_target_group'
  desc 'Returns information about DB proxy target groups.'

  example "
    describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(db_proxy_name target_group_name))
    raise ArgumentError, "#{@__resource_name__}: db_proxy_name must be provided" unless opts[:db_proxy_name] && !opts[:db_proxy_name].empty?
    raise ArgumentError, "#{@__resource_name__}: target_group_name must be provided" unless opts[:target_group_name] && !opts[:target_group_name].empty?
    @display_name = opts[:target_group_name]
    catch_aws_errors do
      resp = @aws.rds_client.describe_db_proxy_target_groups({ db_proxy_name: opts[:db_proxy_name], target_group_name: opts[:target_group_name] })
      @res = resp.target_groups[0].to_h
      create_resource_methods(@res)
    end
  end

  def target_group_name
    return nil unless exists?
    @res[:target_group_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "DB Proxy Target Group Name: #{@display_name}"
  end
end
