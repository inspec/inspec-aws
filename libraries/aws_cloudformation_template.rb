require 'aws_backend'

class AWSCloudFormationTemplate < AwsResourceBase
  name 'aws_cloudformation_template'
  desc 'Returns information about a new or existing template.'
  example <<-EXAMPLE
    describe aws_cloudformation_template(stack_name: 'STACK_NAME') do
      it { should exist }
    end

    describe aws_cloudformation_template(stack_set_name: 'STACK_SET_NAME') do
      it { should exist }
    end

    describe aws_cloudformation_template(template_url: 'TEMPLATE_URL') do
      it { should exist }
    end

    describe aws_cloudformation_template(template_body: 'TEMPLATE_BODY') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(stack_name stack_set_name template_url template_body))
    @stack_name = opts[:stack_name]
    @template_url = opts[:template_url]
    @query_params = opts.slice(:stack_name, :stack_set_name, :template_url, :template_body)
    @query_stack_name = opts.slice(:stack_name)
    catch_aws_errors do
      resp = @aws.cloudformation_client.get_template_summary(@query_params)
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@template_url}_#{@stack_name}"
  end

  def template_body
    return unless exists?
    catch_aws_errors do
      @template_body ||= @aws.cloudformation_client.get_template(@query_stack_name)
    end
  end

  def stack_name
    return unless exists?
    @res[:stack_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def parameter_keys
    parameters.map(&:parameter_key)
  end

  def default_values
    parameters.map(&:default_value)
  end

  def parameter_types
    parameters.map(&:parameter_type)
  end

  def no_echos
    parameters.map(&:no_echo)
  end

  def descriptions
    parameters.map(&:description)
  end

  def parameter_constraints_allowed_values
    parameters.map(&:parameter_constraints).map(&:allowed_values)
  end

  def resource_types
    resource_identifier_summaries.map(&:resource_type)
  end

  def logical_resource_ids
    resource_identifier_summaries.map(&:logical_resource_ids)
  end

  def resource_identifiers
    resource_identifier_summaries.map(&:resource_identifiers)
  end

  def to_s
    "Stack Name: #{@display_name}"
  end
end
