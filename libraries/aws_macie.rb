require "aws_backend"

class AwsMacieJobTable

  FilterTable.create
    .register_column(:bucket_criteria,         field: :bucket_criteria)
    .register_column(:bucket_definitions,             field: :bucket_definitions)
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
    self.bucket_definitions.any? { |bd| 
      bd.any? { |account|
        (buckets - account[:buckets]).empty?  
      }
    }
  end

  def initialize(job_table, job_name = nil)
    @job_table = job_table
    @job_name = job_name
  end

  def to_s
    @job_name
  end
end


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
        @jobs_table = []
        @buckets = @aws.macie_client.describe_buckets.buckets
        @buckets_table = []
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

  def jobs
    return [] unless @jobs
    AwsMacieJobTable.new(@jobs.items.map(&:to_h))
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

  # def monitoring?(bucket_list)
  #   @jobs.any? { |job|
  #     job.
  #   }
  # end

  def to_s
    "AWS Macie"
  end

  private

  def fetch_aws_region
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[1]
  end
end
