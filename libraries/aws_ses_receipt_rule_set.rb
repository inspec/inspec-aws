require 'aws_backend'

class AWSSESReceiptRuleSet < AwsResourceBase
  name 'aws_ses_receipt_rule_set'
  desc 'Returns the details of the specified receipt rule set.'

  example "
    describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rule_set_name))
    raise ArgumentError, "#{@__resource_name__}: rule_set_name must be provided" unless opts[:rule_set_name] && !opts[:rule_set_name].empty?
    @display_name = opts[:rule_set_name]
    catch_aws_errors do
      resp = @aws.ses_client.describe_receipt_rule_set({ rule_set_name: opts[:rule_set_name] })
      @res = resp.rules[0].to_h
      create_resource_methods(@res)
    end
  end

  def rule_set_name
    return unless exists?
    @res[:rule_set_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def s3_action_topic_arns
    actions.map(&:s3_action).map(&:topic_arn)
  end

  def s3_action_bucket_names
    actions.map(&:s3_action).map(&:bucket_name)
  end

  def s3_action_object_key_prefixes
    actions.map(&:s3_action).map(&:object_key_prefix)
  end

  def s3_action_kms_key_arns
    actions.map(&:s3_action).map(&:kms_key_arn)
  end

  def bounce_action_topic_arns
    actions.map(&:bounce_action).map(&:topic_arn)
  end

  def bounce_action_smtp_reply_codes
    actions.map(&:bounce_action).map(&:smtp_reply_code)
  end

  def bounce_action_status_codes
    actions.map(&:bounce_action).map(&:status_code)
  end

  def bounce_action_messages
    actions.map(&:bounce_action).map(&:message)
  end

  def bounce_action_senders
    actions.map(&:bounce_action).map(&:sender)
  end

  def workmail_action_topic_arns
    actions.map(&:workmail_action).map(&:topic_arn)
  end

  def workmail_action_organization_arns
    actions.map(&:workmail_action).map(&:organization_arn)
  end

  def lambda_action_topic_arns
    actions.map(&:lambda_action).map(&:topic_arn)
  end

  def lambda_action_function_arns
    actions.map(&:lambda_action).map(&:function_arn)
  end

  def lambda_action_invocation_types
    actions.map(&:lambda_action).map(&:invocation_type)
  end

  def stop_action_scopes
    actions.map(&:stop_action).map(&:scope)
  end

  def stop_action_topic_arns
    actions.map(&:stop_action).map(&:topic_arn)
  end

  def add_header_action_header_names
    actions.map(&:add_header_action).map(&:header_name)
  end

  def add_header_action_header_values
    actions.map(&:add_header_action).map(&:header_value)
  end

  def sns_action_topic_arns
    actions.map(&:sns_action).map(&:topic_arn)
  end

  def sns_action_encodings
    actions.map(&:sns_action).map(&:encoding)
  end

  def resource_id
    @display_name
  end

  def to_s
    "Rule Set Name: #{@display_name}"
  end
end
