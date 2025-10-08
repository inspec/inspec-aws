require "aws_backend"

class AWSSecurityHubHub < AwsResourceBase
  name "aws_securityhub_hub"
  desc "Gets information about the Security Hub."

  example "
    describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { hub_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:hub_arn])
    unless opts[:hub_arn] && !opts[:hub_arn].empty?
      raise ArgumentError, "#{@__resource_hub_arn__}: hub_arn must be provided"
    end
    @display_name = opts[:hub_arn]
    catch_aws_errors do
      resp = @aws.securityhub_client.describe_hub({ hub_arn: opts[:hub_arn] })
      @res = resp.to_h
      @hub_arn = @res[:hub_arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @hub_arn
  end

  def hub_arn
    return nil unless exists?
    @hub_arn
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Hub ARN: #{@display_name}"
  end
end
