require "aws_backend"

class AWSRDSDBSecurityGroup < AwsResourceBase
  name "aws_rds_db_security_group"
  desc "Returns information about a db security group."

  example "
    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[db_security_group_name])
    unless opts[:db_security_group_name] &&
             !opts[:db_security_group_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: db_security_group_name must be provided"
    end
    @display_name = opts[:db_security_group_name]
    catch_aws_errors do
      resp =
        @aws.rds_client.describe_db_security_groups(
          { db_security_group_name: opts[:db_security_group_name] }
        )
      @res = resp.db_security_groups[0].to_h
      @db_security_group_arn = @res[:db_security_group_arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @db_security_group_arn
  end

  def db_security_group_name
    return nil unless exists?
    @res[:db_security_group_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "DB Security Group Name: #{@display_name}"
  end

  def ec2_security_group_statuses
    ec2_security_groups.map(&:ec2_security_group_name)
  end

  def ec2_security_group_names
    ec2_security_groups.map(&:ec2_security_group_name)
  end

  def ec2_security_group_ids
    ec2_security_groups.map(&:ec2_security_group_id)
  end

  def ec2_security_group_owner_ids
    ec2_security_groups.map(&:ec2_security_group_owner_id)
  end

  def ip_ranges_statuses
    ip_ranges.map(&:status)
  end

  def ip_ranges_cidrips
    ip_ranges.map(&:cidrip)
  end
end
