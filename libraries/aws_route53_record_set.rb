# frozen_string_literal: true

require 'aws_backend'

class AWSRoute53RecordSet < AwsResourceBase
  name 'aws_route53_record_set'
  desc ''
  example "
    describe aws_route53_record_set(hosted_zone_id: 'value') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { hosted_zone_id: opts, start_record_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(hosted_zone_id start_record_name))
    raise ArgumentError, "#{@__resource_name__}: hosted_zone_id must be provided" unless opts[:hosted_zone_id] && !opts[:hosted_zone_id].empty?
    raise ArgumentError, "#{@__resource_name__}: name must be provided" unless opts[:start_record_name] && !opts[:start_record_name].empty?
    @hosted_zone_id = opts[:hosted_zone_id]
    @start_record_name = opts[:start_record_name]
    catch_aws_errors do
      resp = @aws.route53_client.list_resource_record_sets({ hosted_zone_id: opts[:hosted_zone_id], start_record_name: opts[:name] })
      @res = resp.resource_record_sets[0].to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:hosted_zone_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "resource_share: #{@display_name}"
  end
end
