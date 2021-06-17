# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53HostedZone < AwsResourceBase
  name 'aws_route53_hosted_zone'
  desc 'Gets information about a specified hosted zone including the four name servers assigned to the hosted zone.'

  example "
    describe aws_route53_hosted_zone(id: 'Z3M3LMPEXAMPLE') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(id))
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.route53_client.get_hosted_zone({ id: opts[:id] })
      @res = resp.hosted_zone.to_h
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

  def to_s
    "ID: #{@display_name}"
  end
end
