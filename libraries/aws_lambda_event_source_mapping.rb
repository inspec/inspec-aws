require "aws_backend"

class AWSLambdaEventSourceMapping < AwsResourceBase
  name "aws_lambda_event_source_mapping"
  desc "Returns details about an event source mapping."

  example "
    describe aws_lambda_event_source_mapping(uuid: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { uuid: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:uuid])
    raise ArgumentError, "#{@__resource_name__}: uuid must be provided" unless opts[:uuid] && !opts[:uuid].empty?
    @display_name = opts[:uuid]
    catch_aws_errors do
      resp = @aws.lambda_client.get_event_source_mapping({ uuid: opts[:uuid] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def uuid
    return unless exists?
    @res[:uuid]
  end

  def resource_id
    return "" unless exists?
    @res[:uuid]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "UUID: #{@display_name}"
  end
end
