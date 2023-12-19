require "aws_backend"

class AwsMacieJobTable

  FilterTable.create
    .register_column(:bucket_criteria,         field: :bucket_criteria)
    .register_column(:bucket_definitions, field: :bucket_definitions)
    .register_column(:created_at,     field: :created_at)
    .register_column(:job_id,   field: :job_id)
    .register_column(:job_status,         field: :job_status)
    .register_column(:job_type,           field: :job_type)
    .register_column(:last_run_error_status,        field: :last_run_error_status)
    .register_column(:name,        field: :name)
    .register_column(:user_paused_details, field: :user_paused_details)
    .install_filter_methods_on_resource(self, :job_table)

  attr_reader :job_table, :job_name

  def monitoring?(buckets)
    self.entries.each do |job|
      job[:bucket_definitions].each do |bd|
        buckets = buckets - bd[:buckets] 
      end
    end
    buckets.empty?
  end

  def initialize(job_table, job_name = nil)
    @job_table = job_table
    @job_name = job_name
  end

  def to_s
    @job_name.present? ? @job_name : "AWS Macie Jobs"
  end
end

class AwsMacieBucketTable

  FilterTable.create
    .register_column(:account_id,         field: :account_id)
    .register_column(:allows_unencrypted_object_uploads, field: :allows_unencrypted_object_uploads)
    .register_column(:bucket_arn,     field: :bucket_arn)
    .register_column(:bucket_created_at,   field: :bucket_created_at)
    .register_column(:bucket_name,         field: :bucket_name)
    .register_column(:classifiable_object_count,           field: :classifiable_object_count)
    .register_column(:classifiable_size_in_bytes,        field: :classifiable_size_in_bytes)
    .register_column(:error_code,        field: :error_code)
    .register_column(:error_message, field: :error_message)
    .register_column(:job_details, field: :job_details)
    .register_column(:last_automated_discovery_time, field: :last_automated_discovery_time)
    .register_column(:last_updated, field: :last_updated)
    .register_column(:object_count, field: :object_count)
    .register_column(:object_count_by_encryption_type, field: :object_count_by_encryption_type)
    .register_column(:public_access, field: :public_access)
    .register_column(:region, field: :region)
    .register_column(:replication_details, field: :replication_details)
    .register_column(:sensitivity_score, field: :sensitivity_score)
    .register_column(:server_side_encryption, field: :server_side_encryption)
    .register_column(:shared_access, field: :shared_access)
    .register_column(:size_in_bytes, field: :size_in_bytes)
    .register_column(:size_in_bytes_compressed, field: :size_in_bytes_compressed)
    .register_column(:tags, field: :tags)
    .register_column(:unclassifiable_object_count, field: :unclassifiable_object_count)
    .register_column(:unclassifiable_object_size_in_bytes, field: :unclassifiable_object_size_in_bytes)
    .register_column(:versioning, field: :versioning)
    .install_filter_methods_on_resource(self, :buckets_table)

  attr_reader :buckets_table, :buckets_name

  def initialize(buckets_table, buckets_name = nil)
    @buckets_table = buckets_table
    @buckets_name = buckets_name
  end

  def to_s
    @buckets_name.present? ? @buckets_name : "AWS Macie Buckets"
  end
end

# class AwsMacieFindingTable

#   FilterTable.create
#     .register_column(:account_id,         field: :account_id)
#     .register_column(:archived, field: :archived)
#     .register_column(:category,     field: :category)
#     .register_column(:classification_details,   field: :classification_details)
#     .register_column(:count,         field: :count)
#     .register_column(:created_at,           field: :created_at)
#     .register_column(:description,        field: :description)
#     .register_column(:id,        field: :id)
#     .register_column(:partition, field: :partition)
#     .register_column(:policy_details, field: :policy_details)
#     .register_column(:region, field: :region)
#     .register_column(:resources_affected, field: :resources_affected)
#     .register_column(:sample, field: :sample)
#     .register_column(:schema_version, field: :schema_version)
#     .register_column(:severity, field: :severity)
#     .register_column(:title, field: :title)
#     .register_column(:type, field: :type)
#     .register_column(:updated_at, field: :updated_at)
#     .install_filter_methods_on_resource(self, :job_table)

#   attr_reader :findings_table, :findings_name

#   def initialize(findings_table, findings_name = nil)
#     @findings_table = findings_table
#     @findings_name = findings_name
#   end

#   def to_s
#     @findings_name.present? ? @findings_name : "AWS Macie Findings"
#   end
# end

class AWSMacie < AwsResourceBase
  name "aws_macie"
  desc "Gets information about Macie status and configuration."

  example "
    describe aws_macie do
      it { should be_enabled }
      it { should be_monitoring(['arn1', 'arn2', 'arn3']) }
    end
  "

  attr_reader:buckets, :organization_configuration

  def initialize(opts = {})
    @raw_data = {}
    @res = {}
    @describe_hub = []
    super(opts)
    validate_parameters
    fetch_data
  end

  def fetch_data
    catch_aws_errors do
      begin
        @session = @aws.macie_client.get_macie_session
        @jobs = @aws.macie_client.list_classification_jobs
        @jobs.present? ? @jobs_table = AwsMacieJobTable.new(@jobs.items.map(&:to_h)) : @jobs_table = []
        @buckets = @aws.macie_client.describe_buckets
        @buckets.present? ? @buckets_table = AwsMacieBucketTable.new(@buckets.buckets.map(&:to_h)) : @buckets_table = []
        # @findings = @aws.macie_client.get_findings
        # @findings.present? ? @findings_table = AwsMacieFindingTable.new(@findings.findings.map(&:to_h)) : @findings_table = []
      rescue Aws::Errors::NoSuchEndpointError
        skip_resource(
          "The account contact endpoint is not available in this segment, please review this via the AWS Management Console.",
        )
      end
      return [] if (!@session or @session.empty?) || (!@jobs or @jobs.empty?) || (!@bucket or @bucket.empty?)
      # Can't do this until we setup the user to be a Macie Admin?
      # @organization_configuration = @aws.macie_client.describe_organization_configuration
    end
  end

  def session
    return [] unless @session.present?
    @session
  end

  def jobs
    @jobs_table
  end

  def buckets
    @buckets_table
  end

  def findings
    @findings_table
  end

  def monitoring_buckets?(buckets)
    return false unless @jobs
    b = [buckets] unless buckets.is_a?(Array)
    jobs.monitoring?(b)
  end

  alias monitoring_bucket? monitoring_buckets? 
  
  # jobs.items.first.bucket_definitions.first.to_h[:buckets]
  # aws.macie_client.describe_buckets.buckets.count
  # aws.macie_client.list_classification_jobs.items.first['bucket_definitions']

  # it may be more strait forward to have multiple small resources so this one doesn't get hug

  # aws_macie base resource
  #   - this may have 'session' method via get_macie_session
  #   - members via list_members
  #   - list_organization_admin_accounts ?
  #   - perhaps owner etc.
  #   - usuage_totals - via get_usage_totals
  # aws_macie_jobs ...
  # aws_macie_job(job_id) ...
  # aws_macie_buckets
  # aws_macie_buckets(bucket_name or arn)
  # aws_macie_findings
  #   - list_findings
  # aws_macie_finding
  #   - get_finding_statistics(finding_id)

  def enabled?
    @session.status == "ENABLED"
  end

  def to_s
    "AWS Macie"
  end

  private

  def fetch_aws_region
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[1]
  end
end
