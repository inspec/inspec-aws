# frozen_string_literal: true

require 'aws_backend'

class AwsDbSubnetGroup < AwsResourceBase
  name 'aws_db_subnet_group'
  desc 'Verifies settings for a Subnet Group'
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
      @subnet_group = resp.db_subnet_groups[0].to_h

      create_resource_methods(@subnet_group)
    end
  end

  def exists?
    !@subnet_group.nil? && !@subnet_group.empty?
  end

  def to_s
    "Subnet Group Name #{@display_name}"
  end
end
