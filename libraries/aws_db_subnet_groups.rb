require "aws_backend"

class AwsDbSubnetGroups < AwsResourceBase
  name "aws_db_subnet_groups"
  desc "Verifies settings for a Subnet Group in bulk."
  example <<-EXAMPLE
    describe aws_db_subnet_groups do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table, :subnet_rows, :api_response

  FilterTable.create
    .register_column(:db_subnet_group_names,                field: :db_subnet_group_name)
    .register_column(:db_subnet_group_descriptions,         field: :db_subnet_group_description)
    .register_column(:vpc_ids,                              field: :vpc_id)
    .register_column(:subnet_group_status,                  field: :subnet_group_status)
    .register_column(:subnets,                              field: :subnets)
    .register_column(:db_subnet_group_arns,                 field: :db_subnet_group_arn)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    subnet_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_subnet_groups(pagination_options)
      end
      return [] if !api_response || api_response.empty?

      api_response.db_subnet_groups.each do |subnet_group|
        subnet_group_rows += [{ db_subnet_group_name:           subnet_group.db_subnet_group_name,
                                db_subnet_group_description:    subnet_group.db_subnet_group_description,
                                vpc_id:                         subnet_group.vpc_id,
                                subnet_group_status:            subnet_group.subnet_group_status,
                                subnets:                        return_subnets(subnets: subnet_group.subnets),
                                db_subnet_group_arn:            subnet_group.db_subnet_group_arn }]
      end
      break unless api_response.marker
      pagination_options = { marker: api_response[:marker] }
    end
    @table = subnet_group_rows
  end

  def return_subnets(subnets:)
    @subnet_rows = []
    subnets.each do |subnet|
      @subnet_rows << { subnet_identifier: subnet[:subnet_identifier],
                        subnet_availability_zone: subnet[:subnet_availability_zone],
                        subnet_status: subnet[:subnet_status] }
    end
    subnet_rows
  end
end
