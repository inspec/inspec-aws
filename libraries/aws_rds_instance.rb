require 'aws_backend'

class AwsRdsInstance < AwsResourceBase
  name 'aws_rds_instance'
  desc 'Verifies settings for an RDS instance.'

  example "
    describe aws_rds_instance(db_instance_identifier: 'test-instance-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_instance_identifier: opts } if opts.is_a?(String)
    super(opts)
    unless @resource_data
      validate_parameters(required: [:db_instance_identifier])
      raise ArgumentError, "#{@__resource_name__}: db_instance_identifer must start with a letter followed by up to 62 letters/numbers/hyphens." if opts[:db_instance_identifier] !~ /^[a-z]{1}[0-9a-z\-]{0,62}$/
    end
    @display_name = opts[:db_instance_identifier] || opts.dig(@resource_data, :db_instance_identifier)
    @rds_instance = @resource_data || get_resource(opts)
    create_resource_methods(@rds_instance)
  end

  def resource_id
    "#{@rds_instance? @rds_instance[:db_instance_identifier]: ''}_#{@rds_instance? @rds_instance[:db_name]: ''}_#{@rds_instance? @rds_instance[:master_username]: ''}"
  end

  def has_encrypted_storage?
    @rds_instance[:storage_encrypted]
  end
  # add this alias for consistency with ebs volumes
  alias encrypted? has_encrypted_storage?

  def tags
    tag_list = catch_aws_errors do
      @aws.rds_client.list_tags_for_resource(resource_name: @rds_instance[:db_instance_arn]).tag_list
    end
    map_tags(tag_list)
  end

  def exists?
    !@rds_instance.nil? && !@rds_instance.empty?
  end

  def to_s
    "RDS Instance: #{@display_name}"
  end

  private

  def get_resource(opts)
    catch_aws_errors do
      resp = @aws.rds_client.describe_db_instances(db_instance_identifier: opts[:db_instance_identifier])
      return if resp.db_instances.empty?

      resp.db_instances.first.to_h
    end
  end
end
