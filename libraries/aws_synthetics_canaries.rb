require "aws_backend"

class AWSSyntheticsCanaries < AwsResourceBase
  name "aws_synthetics_canaries"
  desc "Lists the canaries."

  example "
    describe aws_synthetics_canaries do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:ids, field: :id)
    .register_column(:names, field: :name)
    .register_column(:codes, field: :code)
    .register_column(:execution_role_arns, field: :execution_role_arn)
    .register_column(:schedules, field: :schedule)
    .register_column(:run_configs, field: :run_config)
    .register_column(:success_retention_period_in_days, field: :success_retention_period_in_days)
    .register_column(:failure_retention_period_in_days, field: :failure_retention_period_in_days)
    .register_column(:statuses, field: :status)
    .register_column(:timelines, field: :timeline)
    .register_column(:artifact_s3_locations, field: :artifact_s3_location)
    .register_column(:engine_arns, field: :engine_arn)
    .register_column(:runtime_versions, field: :runtime_version)
    .register_column(:vpc_configs, field: :vpc_config)
    .register_column(:visual_references, field: :visual_reference)
    .register_column(:tags, field: :tags)
    .register_column(:artifact_configs, field: :artifact_config)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.synthetics_client.describe_canaries.map do |table|
        table.canaries.map { |table_name| {
          id: table_name.id,
          name: table_name.name,
          code: table_name.code,
          execution_role_arn: table_name.execution_role_arn,
          schedule: table_name.schedule,
          run_config: table_name.run_config,
          success_retention_period_in_days: table_name.success_retention_period_in_days,
          failure_retention_period_in_days: table_name.failure_retention_period_in_days,
          status: table_name.status,
          timeline: table_name.timeline,
          artifact_s3_location: table_name.artifact_s3_location,
          engine_arn: table_name.engine_arn,
          runtime_version: table_name.runtime_version,
          vpc_config: table_name.vpc_config,
          visual_reference: table_name.visual_reference,
          tags: table_name.tags,
          artifact_config: table_name.artifact_config,
        }
        }
      end.flatten
    end
  end
end
