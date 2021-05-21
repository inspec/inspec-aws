# frozen_string_literal: true

require 'aws_backend'

class AWSEventBridgeRule < AwsResourceBase
  name 'aws_eventbridge_rule'
  desc 'Returns domain configuration information about the specified Elasticsearch domain, including the domain ID, domain endpoint, and domain ARN.'

  example "
    describe aws_elasticsearchservice_domain(name: 'rule_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    raise ArgumentError, "#{@__resource_name__}: name must be provided" unless opts[:name] && !opts[:name].empty?
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.eventbridge_client.describe_rule({ name: opts[:name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "domain_name: #{@display_name}"
  end
end
