# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationTemplateSummary < AwsResourceBase
  name 'aws_cloudformation_template_summary'
  desc 'Describes one or more of your job queues.'

  example "
    describe aws_cloudformation_template_summary(template_url: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { template_url: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:template_url])

    raise ArgumentError, "#{@__resource_name__}: template_url must be provided" unless opts[:template_url] && !opts[:template_url].empty?
    @display_name = opts[:template_url]
    catch_aws_errors do
      resp = @aws.cloudformation_client.get_template_summary({ template_url: [opts[:template_url]] })
      @resp = resp.to_h
      create_resource_methods(@resp)
    end
  end

  def template_url
    return nil unless exists?
    @resp[:template_url]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Job Queue Name: #{@display_name}"
  end

  def resource_type
    resource_identifier_summaries.map(&:resource_type)
  end

  def logical_resource_ids
    resource_identifier_summaries.map(&:logical_resource_ids)
  end

  def resource_identifiers
    resource_identifier_summaries.map(&:resource_identifiers)
  end

  def parameter_key
    parameters.map(&:parameter_key)
  end

  def default_value
    parameters.map(&:default_value)
  end

  def parameter_type
    parameters.map(&:parameter_type)
  end

  def no_echo
    parameters.map(&:no_echo)
  end

  def parameter_description
    parameters.map(&:description)
  end
end
