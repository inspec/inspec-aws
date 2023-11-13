require 'aws_backend'

class AwsEmrClusters < AwsResourceBase
  name 'aws_emr_clusters'
  desc 'Verifies settings for a collection of AWS EMR Clusters.'
  example "
    describe aws_emr_clusters do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:cluster_ids, field: :cluster_id)
             .register_column(:cluster_names, field: :cluster_name)
             .register_column(:cluster_arns, field: :cluster_arn)
             .register_column(:application_names, field: :application_names, style: :simple) # TODO: to be tested
             .register_column(:status_states, field: :status_state)
             .register_column(:auto_scaling_roles, field: :auto_scaling_role)
             .register_column(:custom_ami_ids, field: :custom_ami_id)
             .register_column(:ebs_root_volume_sizes, field: :ebs_root_volume_size)
             .register_column(:kerberos_attributes_realms, field: :kerberos_attributes_realm)
             .register_column(:kerberos_attributes_realm_ad_domain_join_users, field: :kerberos_attributes_realm_ad_domain_join_user)
             .register_column(:log_encryption_kms_key_ids, field: :log_encryption_kms_key_id)
             .register_column(:log_uris, field: :log_uri)
             .register_column(:release_labels, field: :release_label)
             .register_column(:scale_down_behaviors, field: :scale_down_behavior)
             .register_column(:service_roles, field: :service_role)
             .register_column(:step_concurrency_levels, field: :step_concurrency_level)
             .register_column(:visible_to_all_users, field: :visible_to_all_users)
             .register_column(:security_configuration_names, field: :security_configuration_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cluster_rows = []
    resp_list_clusters = {}
    pagination_options = {}
    clusters = []

    catch_aws_errors do
      resp_list_clusters = @aws.emr_client.list_clusters(pagination_options)
    end

    return cluster_rows if !resp_list_clusters || resp_list_clusters.empty?

    resp_list_clusters.clusters.each do |list_cluster|
      resp_describe_cluster = @aws.emr_client.describe_cluster(cluster_id: list_cluster.id)
      clusters << resp_describe_cluster.cluster
    end

    clusters.each do |cluster|
      if !cluster.kerberos_attributes.nil?
        kerberos_attributes_realm = cluster.kerberos_attributes.realm
        kerberos_attributes_realm_ad_domain_join_user = cluster.kerberos_attributes.ad_domain_join_user
      end
      cluster_rows += [{ cluster_arn:  cluster.cluster_arn,
        cluster_id:   cluster.id,
        cluster_name: cluster.name,
        status_state: cluster.status.state,
        application_names: cluster.applications.map(&:name),
        auto_scaling_role: cluster.auto_scaling_role,
        custom_ami_id: cluster.custom_ami_id,
        ebs_root_volume_size: cluster.ebs_root_volume_size,
        kerberos_attributes_realm: kerberos_attributes_realm,
        kerberos_attributes_realm_ad_domain_join_user: kerberos_attributes_realm_ad_domain_join_user,
        log_encryption_kms_key_id: cluster.log_encryption_kms_key_id,
        log_uri: cluster.log_uri,
        release_label: cluster.release_label,
        scale_down_behavior: cluster.scale_down_behavior,
        service_role: cluster.service_role,
        step_concurrency_level: cluster.step_concurrency_level,
        security_configuration_name: cluster.security_configuration,
        visible_to_all_users: cluster.visible_to_all_users }]
    end
    @table = cluster_rows
  end
end
