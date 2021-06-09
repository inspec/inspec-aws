# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53HostedZone < AwsResourceBase
  name 'aws_route53_hosted_zone'
  desc ''

  example "
    describe aws_route53_hosted_zone(id: 'value') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(id))
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.route53_client.get_hosted_zone({ id: opts[:id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "id: #{@display_name}"
  end
end
