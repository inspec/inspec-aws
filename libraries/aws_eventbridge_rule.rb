require "aws_backend"

class AWSEventBridgeRule < AwsResourceBase
  name "aws_eventbridge_rule"
  desc "Describes the specified rule."

  example "
    describe aws_eventbridge_rule(name: 'test_rule') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    unless opts[:name] && !opts[:name].empty?
      raise ArgumentError, "#{@__resource_name__}: name must be provided"
    end
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.eventbridge_client.describe_rule({ name: opts[:name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def name
    return nil unless exists?
    @res[:name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Rule Name: #{@display_name}"
  end
end
