require 'aws_backend'

class AWSLambdaEventInvokeConfig < AwsResourceBase
  name 'aws_lambda_event_invoke_config'
  desc 'Retrieves the configuration for asynchronous invocation for a function, version, or alias.'

  example "
    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { function_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(function_name))
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @display_name = opts[:function_name]
    catch_aws_errors do
      resp = @aws.lambda_client.get_function_event_invoke_config({ function_name: opts[:function_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def function_name
    return unless exists?
    @res[:function_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Function Name: #{@display_name}"
  end

  def on_success_destinations
    destination_config.on_success
  end

  def on_faliure_destinations
    destination_config.on_faliure
  end

  def resource_id
    return @display_name unless exists?
    @res[:function_arn]
  end
end
