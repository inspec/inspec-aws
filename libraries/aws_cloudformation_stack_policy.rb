# frozen_string_literal: true

require 'aws_backend'

class AwsCloudformationStack < AwsResourceBase
  name 'aws_cloudformation_stack_policy'
  desc 'Verifies policy settings for an aws CloudFormation Stack'

  example "
    describe aws_cloudformation_stack_policy('stack_name') do
      it { should exist }
    end
  "

  attr_reader :stack_name, :stack_policy_body

  def initialize(opts = {})
    opts = { stack_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:stack_name])
    catch_aws_errors do
      @resp = @aws.cloudformation_client.get_stack_policy(stack_name)
      @stack_policy_body = @resp
    end
  end

  def exists?
    !@stack_policy_body.nil?
  end

  def has_statement?(criteria = {})
    return false unless @stack_policy_body
    document = JSON.parse(URI.decode_www_form_component(@stack_policy_body.stack_policy_body), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document{:Statement}
    statement_match = []

    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    criteria[:Resource] = criteria[:Resource].is_a?(Array) ? criteria[:Resource].sort : criteria[:Resource]
    statements.each do |s|
      actions    = s[:Action] || []
      notactions = s[:NotAction] || []
      effect     = s[:Effect]
      resource   = s[:Resource].is_a?(Array) ? s[:Resource].sort : s[:Resource]

      action_match = criteria[:Action].nil? ? true : actions.include?(criteria[:Action])

      no_action_match = criteria[:NotAction].nil? ? true : notactions.include?(criteria[:NotAction])

      effect_match = criteria[:Effect].nil? ? true : effect.eql?(criteria[:Effect])

      resource_match = criteria[:Resource].nil? ? true : resource.eql?(criteria[:Resource])

      statement_match.push(action_match && no_action_match && effect_match && resource_match)
    end
    statement_match.include?(true)
  end

  def statement_count
    return false unless @stack_policy_body
    document = JSON.parse(URI.decode_www_form_component(@stack_policy_body.stack_policy_body), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
    statements.length
  end
    end


  def to_s
    "AWS CloudFormation Stack Policy  for #{@stack_name}"
  end
end
