require "aws_backend"

class AWSSecurityHub < AwsResourceBase
  name "aws_securityhub"
  desc "Gets information about the Security Hub."

  example "
    describe aws_securityhub do
      it { should be_subscribed }
    end
  "

  attr_reader :describe_hub, :res, :hub_arn, :subscribed_at, :auto_enable_controls, :control_finding_generator

  def initialize(opts = {})
    @raw_data = {}
    @res = {}
    @describe_hub = []
    super(opts)
    validate_parameters
    catch_aws_errors do
      @describe_hub = @aws.securityhub_client.describe_hub
      @res = @describe_hub.to_h.presence || {}
      create_resource_methods(@res) unless @res.nil?
    end
  end

  def subscribed?
    @res[:subscribed_at].present? || !@res.empty?
  end

  alias exists? subscribed?
  alias exist? subscribed?

  def resource_id
    @res[:hub_arn].presence || ""
  end

  def to_s
    "Security Hub: #{resource_id}"
  end
end
