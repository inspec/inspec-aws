require "aws_backend"

class AWSMQBroker < AwsResourceBase
  name "aws_mq_broker"
  desc "Describes a Amazon MQ broker."

  example "
    describe aws_mq_broker(broker_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { broker_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:broker_id])
    raise ArgumentError, "#{@__resource_name__}: broker_id must be provided" unless opts[:broker_id] && !opts[:broker_id].empty?
    @display_name = opts[:broker_id]
    resp = @aws.mq_client.describe_broker({ broker_id: opts[:broker_id] })
    @brokers = resp.to_h
    create_resource_methods(@brokers)
  end

  def broker_id
    return nil unless exists?
    @brokers[:broker_id]
  end

  def resource_id
    @brokers? @brokers[:broker_id] : @display_name
  end

  def exists?
    !@brokers.nil? && !@brokers.empty?
  end

  def to_s
    "Broker ID: #{@display_name}"
  end
end
