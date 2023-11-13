require 'aws_backend'

class AWSSignerSigningProfile < AwsResourceBase
  name 'aws_signer_signing_profile'
  desc 'Returns information on a specific signing profile.'

  example "
    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { profile_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(profile_name))
    raise ArgumentError, "#{@__resource_name__}: profile_name must be provided" unless opts[:profile_name] && !opts[:profile_name].empty?
    @display_name = opts[:profile_name]
    catch_aws_errors do
      resp = @aws.signer_client.get_signing_profile({ profile_name: opts[:profile_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def profile_name
    return unless exists?
    @res[:profile_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @display_name
  end

  def to_s
    "Profile Name: #{@display_name}"
  end
end
