# frozen_string_literal: true

require 'aws_backend'

class AwsDbParameterGroup < AwsResourceBase
  name 'aws_db_parameter_group'
  desc 'Verifies settings for a Parameter Group.'
  example "
    describe aws_db_parameter_group(db_parameter_group_name: 'parameter-group') do
      it { should exist }
    end

    describe aws_db_parameter_group('parameter-group') do
      its('db_parameter_group_name') { should eq 'parameter-group' }
    end
  "

  def initialize(opts = {})
    opts = { db_parameter_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:db_parameter_group_name])
    @display_name = opts[:db_parameter_group_name]

    catch_aws_errors do
      resp = @aws.rds_client.describe_db_parameter_groups({ db_parameter_group_name: opts[:db_parameter_group_name] })
      if resp.db_parameter_groups.first.nil?
        empty_response_warn
      else
        @parameter_group = resp.db_parameter_groups[0].to_h
        @db_parameter_group_arn = @parameter_group[:db_parameter_group_arn]
        create_resource_methods(@parameter_group)
      end
    end
  end

  def resource_id
    @db_parameter_group_arn
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "Parameter Group Name #{@display_name}"
  end

  def name
    db_parameter_group_name if exists?
  end
end
