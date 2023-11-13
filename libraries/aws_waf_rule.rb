require 'aws_backend'

class AWSWAFRule < AwsResourceBase
  name 'aws_waf_rule'
  desc 'Describes one WAF rule.'

  example "
    describe aws_waf_rule(rule_id: 'RULE_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { rule_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(rule_id))
    raise ArgumentError, "#{@__resource_name__}: rule_id must be provided" unless opts[:rule_id] && !opts[:rule_id].empty?
    @display_name = opts[:rule_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_rule({ rule_id: opts[:rule_id] })
      @resp = resp.rule.to_h
      create_resource_methods(@resp)
    end
  end

  def rule_id
    return unless exists?
    @resp[:rule_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Rule ID: #{@display_name}"
  end

  def predicates_negated
    predicates.map(&:negated)
  end

  def predicates_type
    predicates.map(&:type)
  end

  def predicates_data_id
    predicates.map(&:data_id)
  end

  def resource_id
    @display_name
  end
end
