require 'aws_backend'

class AwsDbSubnetGroup < AwsResourceBase
  name 'aws_db_subnet_group'
  desc 'Verifies settings for a Subnet Group.'
  example "
    describe aws_subnet_group(db_subnet_group_name: 'subnet-group') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_subnet_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:db_subnet_group_name])
    @display_name = opts[:db_subnet_group_name]

    catch_aws_errors do
      resp = @aws.rds_client.describe_db_subnet_groups({ db_subnet_group_name: opts[:db_subnet_group_name] })
      if resp.db_subnet_groups.first.nil?
        empty_response_warn
      else
        @subnet_group = resp.db_subnet_groups[0].to_h
        @db_subnet_group_arn = @subnet_group[:db_subnet_group_arn]
        create_resource_methods(@subnet_group)
      end
    end
  end

  def resource_id
    @db_subnet_group_arn
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "Subnet Group Name #{@display_name}"
  end

  def name
    db_subnet_group_name if exists?
  end
end
