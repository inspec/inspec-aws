require 'aws_backend'

class AWSRDSDBSecurityGroups < AwsResourceBase
  name 'aws_rds_db_security_groups'
  desc 'Returns information about all the db security group.'

  example "
    describe aws_rds_db_security_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:db_security_group_names, field: :db_security_group_name)
             .register_column(:db_security_group_descriptions, field: :db_security_group_description)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:ec2_security_groups, field: :ec2_security_groups, style: :simple)
             .register_column(:ip_ranges, field: :ip_ranges,  style: :simple)
             .register_column(:db_security_group_arns, field: :db_security_group_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.rds_client.describe_db_security_groups(@query_params).map do |table|
        table.db_security_groups.map { |table_name| {
          owner_id: table_name.owner_id,
          db_security_group_name: table_name.db_security_group_name,
          db_security_group_description: table_name.db_security_group_description,
          vpc_id: table_name.vpc_id,
          ec2_security_groups: table_name.ec2_security_groups,
          ip_ranges: table_name.ip_ranges,
          db_security_group_arn: table_name.db_security_group_arn,
        }
        }
      end.flatten
    end
  end
end
