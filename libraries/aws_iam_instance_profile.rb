# frozen_string_literal: true

require 'aws_backend'

class AWSIAMInstanceProfile < AwsResourceBase
  name 'aws_iam_instance_profile'
  desc ''

  example "
    describe aws_iam_instance_profile(instance_profile_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { instance_profile_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:instance_profile_name])
    raise ArgumentError, "#{@__resource_name__}: instance_profile_name must be provided" unless opts[:instance_profile_name] && !opts[:instance_profile_name].empty?
    @display_name = opts[:instance_profile_name]
    catch_aws_errors do
      resp = @aws.iam_client.get_instance_profile({ instance_profile_name: opts[:instance_profile_name] })
      @res = resp.instance_profile.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:instance_profile_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "instance_profile_name: #{@display_name}"
  end
end
