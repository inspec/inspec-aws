# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53ResolverResolverRule < AwsResourceBase
  name 'aws_route53resolver_resolver_rule'
  desc ''

  example "
    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'resolver_rule_id_test') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { resolver_rule_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(resolver_rule_id))
    raise ArgumentError, "#{@__resource_name__}: resolver_rule_id must be provided" unless opts[:resolver_rule_id] && !opts[:resolver_rule_id].empty?
    @display_name = opts[:resolver_rule_id]
    catch_aws_errors do
      resp = @aws.route53resolver_client.get_resolver_rule({ resolver_rule_id: opts[:resolver_rule_id] })
      @res = resp.resolver_rule.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:resolver_rule_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "resolver_rule_id: #{@display_name}"
  end
end
