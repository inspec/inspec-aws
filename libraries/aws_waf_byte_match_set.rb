require 'aws_backend'

class AWSWAFByteMatchSet < AwsResourceBase
  name 'aws_waf_byte_match_set'
  desc 'Describes one WAF byte set.'

  example "
    describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { byte_match_set_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(byte_match_set_id))
    raise ArgumentError, "#{@__resource_name__}: byte_match_set_id must be provided" unless opts[:byte_match_set_id] && !opts[:byte_match_set_id].empty?
    @display_name = opts[:byte_match_set_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_byte_match_set({ byte_match_set_id: opts[:byte_match_set_id] })
      @resp = resp.byte_match_set.to_h
      create_resource_methods(@resp)
    end
  end

  def byte_match_set_id
    return nil unless exists?
    @resp[:byte_match_set_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Byte Match Set ID: #{@display_name}"
  end

  def byte_match_tuples_field_to_matches
    byte_match_tuples.map(&:field_to_match)
  end

  def byte_match_tuples_field_to_match_types
    byte_match_tuples.map(&:field_to_match).map(&:type)
  end

  def byte_match_tuples_field_to_match_data
    byte_match_tuples.map(&:field_to_match).map(&:data)
  end

  def byte_match_tuples_target_strings
    byte_match_tuples.map(&:target_string)
  end

  def byte_match_tuples_text_transformations
    byte_match_tuples.map(&:text_transformation)
  end

  def byte_match_tuples_positional_constraints
    byte_match_tuples.map(&:positional_constraint)
  end

  def resource_id
    @display_name
  end
end
