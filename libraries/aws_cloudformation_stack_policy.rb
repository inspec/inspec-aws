# frozen_string_literal: true

require 'aws_backend'

class AwsCloudformationStackPolicy < AwsResourceBase
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
      name = { stack_name: opts[:stack_name] }
      @resp = @aws.cloudformation_client.get_stack_policy(name)
    end
    @stack_policy_body = @resp
  end

  def exists?
    !@stack_policy_body.nil?
  end

  def has_statement?(criteria = {})
    return false unless @stack_policy_body

    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    criteria[:Resource] = criteria[:Resource].is_a?(Array) ? criteria[:Resource].sort : criteria[:Resource]
    statements.any? do |statement|
      actions    = statement[:Action] || []
      notactions = statement[:NotAction] || []
      effect     = statement[:Effect]
      resource   = statement[:Resource].is_a?(Array) ? statement[:Resource].sort : statement[:Resource]

      action_match = criteria[:Action].nil? ? true : actions.include?(criteria[:Action])

      no_action_match = criteria[:NotAction].nil? ? true : notactions.include?(criteria[:NotAction])

      effect_match = criteria[:Effect].nil? ? true : effect.eql?(criteria[:Effect])

      resource_match = criteria[:Resource].nil? ? true : resource.eql?(criteria[:Resource])

      (action_match && no_action_match && effect_match && resource_match)
    end
  end

  def statement_count
    return false unless statements

    statements.length
  end

  def to_s
    "AWS CloudFormation Stack Policy  for #{@stack_name}"
  end

  private

  def statements
    @statements ||= calculate_statements || []
  end

  def calculate_statements
    return unless @stack_policy_body

    document_string = @stack_policy_body.stack_policy_body
    document = JSON.parse(document_string, symbolize_names: true)
    document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
  end
end
