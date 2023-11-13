require 'aws_backend'

class AWSLambdaVersion < AwsResourceBase
  name 'aws_lambda_version'
  desc 'Returns information about a version of an Lambda layer.'

  example "
    describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(layer_name version_number))
    raise ArgumentError, "#{@__resource_name__}: layer_name must be provided" unless opts[:layer_name] && !opts[:layer_name].empty?
    @display_name = opts[:layer_name]
    catch_aws_errors do
      resp = @aws.lambda_client.get_layer_version({ layer_name: opts[:layer_name], version_number: opts[:version_number] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def version_number
    return unless exists?
    @res[:version_number]
  end

  def resource_id
    @res ? @res[:layer_arn] : @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Lambda Version Number: #{@display_name}"
  end
end
