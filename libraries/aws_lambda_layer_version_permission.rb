require "aws_backend"

class AWSLambdaLayerVersionPermission < AwsResourceBase
  name "aws_lambda_layer_version_permission"
  desc "Returns the permission policy for a version of an Lambda layer."

  example "
    describe aws_lambda_layer_version_permission(layer_name: 'LAYER_NAME', version_number: 'VERSION_NUMBER') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { layer_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(layer_name version_number))
    raise ArgumentError, "#{@__resource_name__}: layer_name must be provided" unless opts[:layer_name] && !opts[:layer_name].empty?
    raise ArgumentError, "#{@__resource_name__}: version_number must be provided" unless opts[:version_number]
    @display_name = opts[:layer_name]
    catch_aws_errors do
      resp = @aws.lambda_client.get_layer_version_policy({ layer_name: opts[:layer_name], version_number: opts[:version_number] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def layer_name
    return unless exists?
    @res[:layer_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Layer Name: #{@display_name}"
  end
end
