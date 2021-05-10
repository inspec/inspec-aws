# frozen_string_literal: true

require 'aws_backend'

class AwsRdsGroupOption < AwsResourceBase
  name 'aws_rds_group_option'
  desc 'Verifies settings for an RDS Cluster'

  example "
    describe aws_rds_group_option(engine_name: 'test-engine_name') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { engine_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(engine_name option_group_name ))

    #raise ArgumentError, "#{@__resource_name__}: db_cluster_identifier must start with a letter followed by up to 62 letters/numbers/hyphens." if opts[:db_cluster_identifier] !~ /^[a-z]{1}[0-9a-z\-]{0,62}$/




    if opts.key?(:engine_name)
      param = { engine_name: opts[:engine_name] }
    elsif opts.key?(:option_group_name)
      param = { option_group_name: opts[:option_group_name] }
    else
      raise ArgumentError, "#{@__resource_name__}: db_cluster_identifier must start with a letter followed by up to 62 letters/numbers/hyphens."
    end


    catch_aws_errors do
      @display_name = opts[:engine_name]

      begin
        resp = @aws.rds_client.describe_option_groups(param)
        return if resp.option_groups_list.empty?
        @rds_cluster = resp.option_groups_list[0].to_h
      rescue Aws::RDS::Errors::OptionGroupNotFoundFault
        return
      end
      create_resource_methods(@rds_cluster)
    end
  end

  def exists?
    !@rds_cluster.to_s.empty?
  end

  def to_s
    "RDS Cluster #{@display_name}"
  end
end

