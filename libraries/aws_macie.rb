require "aws_backend"

class AWSMacie < AwsResourceBase
  name "aws_macie"
  desc "Gets information about Macie status and configuration."

  example "
    describe aws_macie do
      it { should be_enabled }
      it { should be_monitoring(['arn1', 'arn2', 'arn3']) }
    end
  "

  attr_reader :session, :jobs, :buckets, :organization_configuration

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
      @session = @aws.macie_client.get_macie_session
      @jobs = @aws.macie_client.list_classification_jobs
      @buckets = @aws.macie_client.describe_buckets
      # Can't do this until we setup the user to be a Macie Admin?
      # @organization_configuration = @aws.macie_client.describe_organization_configuration
    end
  end

  # jobs.items.first.bucket_definitions.first.to_h[:buckets]
  # aws.macie_client.describe_buckets.buckets.count
  # aws.macie_client.list_classification_jobs.items.first['bucket_definitions']

  # it may be more straitforward to have multiple small resources so this one doesn't get hug

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
end
