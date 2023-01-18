require "aws_backend"

class AwsRdsOptionGroups < AwsResourceBase
  name "aws_rds_option_groups"
  desc "Verifies settings for a collection AWS RDS Clusters."
  example "
    describe aws_rds_group_options do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:option_group_names, field: :option_group_name)
    .register_column(:option_group_description, field: :option_group_description)
    .register_column(:engine_names, field: :engine_name)
    .register_column(:major_engine_versions, field: :major_engine_version)
    .register_column(:option_group_arns, field: :option_group_arn)
    .register_column(:vpc_ids, field: :vpc_id)
    .register_column(:allows_vpc_and_non_vpc_instance_memberships, field: :allows_vpc_and_non_vpc_instance_memberships)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    option_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @response = @aws.rds_client.describe_option_groups(pagination_options)
      end
      return option_group_rows if !@response || @response.empty?
      @response.option_groups_list.each do |rds_option_group|
        option_group_rows += [{ option_group_name:                                       rds_option_group.option_group_name,
                                option_group_description:                                rds_option_group.option_group_description,
                                engine_name:                                             rds_option_group.engine_name,
                                major_engine_version:                                    rds_option_group.major_engine_version,
                                option_group_arn:                                        rds_option_group.option_group_arn,
                                vpc_id:                                                  rds_option_group.vpc_id,
                                allows_vpc_and_non_vpc_instance_memberships:             rds_option_group.allows_vpc_and_non_vpc_instance_memberships }]
      end
      break unless @response.marker
      pagination_options = { marker: @response[:marker] }
    end
    @table = option_group_rows
  end
end
