# frozen_string_literal: true

require 'aws_backend'

class AWSWAFSQLInjectionMatchSet < AwsResourceBase
  name 'aws_waf_sql_injection_match_set'
  desc 'Describes one WAF SQL Injection match set.'

  example "
    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { sql_injection_match_set_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(sql_injection_match_set_id))
    raise ArgumentError, "#{@__resource_name__}: sql_injection_match_set_id must be provided" unless opts[:sql_injection_match_set_id] && !opts[:sql_injection_match_set_id].empty?
    @display_name = opts[:sql_injection_match_set_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_sql_injection_match_set({ sql_injection_match_set_id: opts[:sql_injection_match_set_id] })
      @resp = resp.sql_injection_match_set.to_h
      create_resource_methods(@resp)
    end
  end

  def sql_injection_match_set_id
    return nil unless exists?
    @resp[:sql_injection_match_set_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "SQL Injection Match Set ID: #{@display_name}"
  end

  def sql_injection_match_tuples_field_to_match_types
    sql_injection_match_tuples.map(&:field_to_match).map(&:type)
  end

  def sql_injection_match_tuples_field_to_match_data
    sql_injection_match_tuples.map(&:field_to_match).map(&:data)
  end

  def sql_injection_match_tuples_text_transformations
    sql_injection_match_tuples.map(&:text_transformation)
  end

  def resource_id
    @display_name
  end
end
