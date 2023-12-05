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

  attr_reader :monitoring_list, :enabled, :jobs

  def initialize(opts = {})
    @raw_data = {}
    @res = {}
    @describe_hub = []
    super(opts)
    validate_parameters
    catch_aws_errors do
      @session = @aws.macie_client.get_macie_session
      @jobs = @aws.macie_client.list_classification_jobs
      @buckets = @aws.macie_client.describe_buckets
      @organization_configuration = @aws.macie_client.describe_organization_configuration
    end
  end

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
