require "aws_backend"

class AwsRdsOptionGroup < AwsResourceBase
  name "aws_rds_option_group"
  desc "Verifies settings for an RDS Option Group."

  example "
    describe aws_rds_option_group(option_group_name: 'test-option_group_name') do
      it { should exist }
    end

    describe aws_rds_option_group('test-option_group_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { option_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(option_group_name))
    raise ArgumentError, "#{@__resource_name__}: .option_group_name must be a string" unless opts.key?(:option_group_name)
    param = { option_group_name: opts[:option_group_name] }
    @display_name = opts[:option_group_name]

    catch_aws_errors do
      resp = @aws.rds_client.describe_option_groups(param)
      return if resp.option_groups_list.empty?
      @rds_cluster = resp.option_groups_list[0].to_h

      create_resource_methods(@rds_cluster)
    end
  end

  def resource_id
    @rds_cluster? @rds_cluster[:option_group_arn]: ""
  end

  def exists?
    !!@rds_cluster && !@rds_cluster.empty?
  end

  def to_s
    "RDS Option Group: #{@display_name}"
  end
end
