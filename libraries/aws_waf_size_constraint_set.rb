require 'aws_backend'

class AWSWAFSizeConstraintSet < AwsResourceBase
  name 'aws_waf_size_constraint_set'
  desc 'Describes one WAF size constraint set.'

  example "
    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { size_constraint_set_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(size_constraint_set_id))
    raise ArgumentError, "#{@__resource_name__}: size_constraint_set_id must be provided" unless opts[:size_constraint_set_id] && !opts[:size_constraint_set_id].empty?
    @display_name = opts[:size_constraint_set_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_size_constraint_set({ size_constraint_set_id: opts[:size_constraint_set_id] })
      @resp = resp.size_constraint_set.to_h
      create_resource_methods(@resp)
    end
  end

  def size_constraint_set_id
    return unless exists?
    @resp[:size_constraint_set_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Size Constraint Set ID: #{@display_name}"
  end

  def size_constraints_field_to_match_types
    size_constraints.map(&:field_to_match).map(&:type)
  end

  def size_constraints_field_to_match_data
    size_constraints.map(&:field_to_match).map(&:data)
  end

  def size_constraints_text_transformations
    size_constraints.map(&:text_transformation)
  end

  def size_constraints_comparison_operators
    size_constraints.map(&:comparison_operator)
  end

  def size_constraints_sizes
    size_constraints.map(&:size)
  end

  def resource_id
    @display_name
  end
end
