require "aws_backend"

class AWSSESTemplate < AwsResourceBase
  name "aws_ses_template"
  desc "Displays the template object (which includes the Subject line, HTML part and text part) for the template you specify."

  example "
    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(template_name))
    raise ArgumentError, "#{@__resource_name__}: template_name must be provided" unless opts[:template_name] && !opts[:template_name].empty?
    @display_name = opts[:template_name]
    catch_aws_errors do
      resp = @aws.ses_client.get_template({ template_name: opts[:template_name] })
      @res = resp.template.to_h
      create_resource_methods(@res)
    end
  end

  def template_name
    return unless exists?
    @res[:template_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Template Name: #{@display_name}"
  end
end
