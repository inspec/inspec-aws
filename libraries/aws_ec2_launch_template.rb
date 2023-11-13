require 'aws_backend'

class AWSEc2LaunchTemplate < AwsResourceBase
  name 'aws_ec2_launch_template'
  desc 'Audits Launch Template.'
  example "describe aws_ec2_launch_template(launch_template_name: 'test-launch-temlate') do
             it { should exist }
           end
"

  def initialize(opts = {})
    opts = { launch_template_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(launch_template_id launch_template_name))

    if opts[:launch_template_id] && !opts[:launch_template_id].empty? # Use instance_id, if provided
      if !opts[:launch_template_id].is_a?(String) || opts[:launch_template_id] !~ /(^lt-[0-9a-f]{8})|(^i-[0-9a-f]{17})$/
        raise ArgumentError, "#{@__resource_name__}: `launch_template_id` must be a string in the format of 'lt-' followed by 8 or 17 hexadecimal characters."
      end
      @display_name = opts[:launch_template_id]
      launch_template_arguments = { launch_template_ids: [opts[:launch_template_id]] }
    elsif opts[:launch_template_name] && !opts[:launch_template_name].empty? # Otherwise use name, if provided
      @display_name = opts[:launch_template_name]
      launch_template_arguments = { launch_template_names: [opts[:launch_template_name]] }
    else
      raise ArgumentError, "#{@__resource_name__}: either instance_id or name must be provided."
    end

    catch_aws_errors do

      resp = @aws.compute_client.describe_launch_templates(launch_template_arguments)
      @launch_templates = resp.launch_templates[0].to_h

      create_resource_methods(@launch_templates)
    end
  end

  def exists?
    !@launch_templates.nil? && !@launch_templates.empty?
  end

  def resource_id
    @launch_templates ? @launch_templates[:launch_template_id] : @display_name
  end

  def to_s
    "Launch Template: #{@display_name}"
  end
end
