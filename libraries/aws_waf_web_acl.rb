require 'aws_backend'

class AWSWAFWebACL < AwsResourceBase
  name 'aws_waf_web_acl'
  desc 'Describes one WAF Web ACL.'

  example "
    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { web_acl_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(web_acl_id))
    raise ArgumentError, "#{@__resource_name__}: web_acl_id must be provided" unless opts[:web_acl_id] && !opts[:web_acl_id].empty?
    @display_name = opts[:web_acl_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_web_acl({ web_acl_id: opts[:web_acl_id] })
      @resp = resp.web_acl.to_h
      create_resource_methods(@resp)
    end
  end

  def web_acl_id
    return nil unless exists?
    @resp[:web_acl_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Web ACL ID: #{@display_name}"
  end

  def rules_priorities
    rules.map(&:priority)
  end

  def rules_rule_ids
    rules.map(&:rule_id)
  end

  def rules_actions
    rules.map(&:action)
  end

  def rules_action_types
    rules.map(&:action).map(&:type)
  end

  def rules_override_actions
    rules.map(&:override_action)
  end

  def rules_override_action_types
    rules.map(&:override_action).map(&:type)
  end

  def rules_types
    rules.map(&:type)
  end

  def rules_excluded_rules
    rules.map(&:excluded_rules)
  end

  def rules_excluded_rules_rule_ids
    rules.map(&:excluded_rules).map(&:rule_id)
  end

  def resource_id
    @display_name
  end
end
