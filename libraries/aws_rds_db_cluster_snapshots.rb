require 'aws_backend'

class AWSRDSDBClusterSnapShots < AwsResourceBase
  name 'aws_rds_db_cluster_snapshots'
  desc 'Returns information about DB cluster snapshots.'

  example "
    describe aws_rds_db_cluster_snapshots do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:availability_zones, field: :availability_zones)
             .register_column(:db_cluster_snapshot_identifiers, field: :db_cluster_snapshot_identifier)
             .register_column(:db_cluster_identifiers, field: :db_cluster_identifier)
             .register_column(:snapshot_create_times, field: :snapshot_create_time)
             .register_column(:engines, field: :engine)
             .register_column(:engine_modes, field: :engine_mode)
             .register_column(:allocated_storages, field: :allocated_storage)
             .register_column(:statuses, field: :status)
             .register_column(:ports, field: :port)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:cluster_create_times, field: :cluster_create_time)
             .register_column(:master_usernames, field: :master_username)
             .register_column(:engine_versions, field: :engine_version)
             .register_column(:license_models, field: :license_model)
             .register_column(:snapshot_types, field: :snapshot_type)
             .register_column(:percent_progresses, field: :percent_progress)
             .register_column(:storage_encrypted, field: :storage_encrypted)
             .register_column(:kms_key_ids, field: :kms_key_id)
             .register_column(:db_cluster_snapshot_arns, field: :db_cluster_snapshot_arn)
             .register_column(:source_db_cluster_snapshot_arns, field: :source_db_cluster_snapshot_arn)
             .register_column(:iam_database_authentication_enabled, field: :iam_database_authentication_enabled)
             .register_column(:tag_lists, field: :tag_list)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_records] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_cluster_snapshots(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.db_cluster_snapshots.each do |res|
        rows += [{
          availability_zones: res.availability_zones,
                   db_cluster_snapshot_identifier: res.db_cluster_snapshot_identifier,
                   db_cluster_identifier: res.db_cluster_identifier,
                   snapshot_create_time: res.snapshot_create_time,
                   engine: res.engine,
                   engine_mode: res.engine_mode,
                   allocated_storage: res.allocated_storage,
                   status: res.status,
                   port: res.port,
                   vpc_id: res.vpc_id,
                   cluster_create_time: res.cluster_create_time,
                   master_username: res.master_username,
                   engine_version: res.engine_version,
                   license_model: res.license_model,
                   snapshot_type: res.snapshot_type,
                   percent_progress: res.percent_progress,
                   storage_encrypted: res.storage_encrypted,
                   kms_key_id: res.kms_key_id,
                   db_cluster_snapshot_arn: res.db_cluster_snapshot_arn,
                   source_db_cluster_snapshot_arn: res.source_db_cluster_snapshot_arn,
                   iam_database_authentication_enabled: res.iam_database_authentication_enabled,
                   tag_list: res.tag_list,
        }]
      end
      break unless @api_response.marker
      @query_params[:marker] = @api_response.marker
    end
    rows
  end
end
