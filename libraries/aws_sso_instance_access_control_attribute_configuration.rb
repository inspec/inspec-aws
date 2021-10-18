# frozen_string_literal: true

require 'aws_backend'

class AWSSSOInstanceAccessControlAttributeConfiguration < AwsResourceBase
  name 'aws_sso_instance_access_control_attribute_configuration'
  desc 'Returns the list of Amazon Web Services SSO identity store attributes that have been configured to work with attributes-based access control (ABAC) for the specified Amazon Web Services SSO instance.'

  example "
    describe aws_sso_instance_access_control_attribute_configuration(instance_arn: 'INSTANCE_ARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(instance_arn))
    raise ArgumentError, "#{@__resource_name__}: instance_arn must be provided" unless opts[:instance_arn] && !opts[:instance_arn].empty?
    @display_name = opts[:instance_arn]
    catch_aws_errors do
      resp = @aws.sso_client.describe_instance_access_control_attribute_configuration({ instance_arn: opts[:instance_arn] })
      @res = resp.rules[0].to_h
      create_resource_methods(@res)
    end
  end

  def instance_arn
    return nil unless exists?
    @res[:instance_arn]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def keys
    (instance_access_control_attribute_configuration.map(&:access_control_attributes)).map(&:key)
  end

  def sources
    (instance_access_control_attribute_configuration.map(&:access_control_attributes)).map(&:sources)
  end

  def to_s
    "Instance ARN: #{@display_name}"
  end
end
