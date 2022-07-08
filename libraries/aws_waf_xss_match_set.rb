# frozen_string_literal: true

require 'aws_backend'

class AWSWAFXSSMatchSet < AwsResourceBase
  name 'aws_waf_xss_match_set'
  desc 'Describes one WAF XSS match set.'

  example "
    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { xss_match_set_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(xss_match_set_id))
    raise ArgumentError, "#{@__resource_name__}: xss_match_set_id must be provided" unless opts[:xss_match_set_id] && !opts[:xss_match_set_id].empty?
    @display_name = opts[:xss_match_set_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_xss_match_set({ xss_match_set_id: opts[:xss_match_set_id] })
      @resp = resp.xss_match_set.to_h
      create_resource_methods(@resp)
    end
  end

  def xss_match_set_id
    return nil unless exists?
    @resp[:xss_match_set_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "XSS Match Set ID: #{@display_name}"
  end

  def xss_match_tuples_field_to_match_types
    xss_match_tuples.map(&:field_to_match).map(&:type)
  end

  def xss_match_tuples_field_to_match_data
    xss_match_tuples.map(&:field_to_match).map(&:data)
  end

  def xss_match_tuples_text_transformations
    xss_match_tuples.map(&:text_transformation)
  end

  def resource_id
    @display_name
  end
end
