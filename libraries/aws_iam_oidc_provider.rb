require 'aws_backend'

class AWSIAMOIDCProvider < AwsResourceBase
  name 'aws_iam_oidc_provider'
  desc 'Retrieves information about the specified  specified OpenID Connect (OIDC) provider resource.'

  example "
    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { open_id_connect_provider_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:open_id_connect_provider_arn])
    raise ArgumentError, "#{@__resource_name__}: open_id_connect_provider_arn must be provided" unless opts[:open_id_connect_provider_arn] && !opts[:open_id_connect_provider_arn].empty?
    @display_name = opts[:open_id_connect_provider_arn]
    catch_aws_errors do
      resp = @aws.iam_client.get_open_id_connect_provider({ open_id_connect_provider_arn: opts[:open_id_connect_provider_arn] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? @display_name: ''
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Open ID Connect Provider ARN: #{@display_name}"
  end
end
