# frozen_string_literal: true

require 'aws_backend'

class AwsEcrPolicy < AwsResourceBase
  name 'aws_ecr_policy'
  desc 'Verifies policy settings for an AWS ECR Repository'

  example "
    describe aws_ecr_policy('my-repository') do
      it { should exist }
    end
  "
  attr_reader :repository_name

  def initialize(opts = {})
    # Create a repository_name:<value> pair if the argument is a string object.
    opts = { repository_name: opts } if opts.is_a?(String)
    # Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    super(opts)
    validate_parameters(required: %i(repository_name))
    @repo_name = { "repository_name": opts[:repository_name] }
    @display_name = opts[:repository_name]
    catch_aws_errors do
      resp = @aws.ecr_client.get_repository_policy(@repo_name)
      @repo_policy = resp.policy_text
    end
  end

  def exists?
    !@repo_policy.nil?
  end

  def has_statement?(criteria = {})
    return false unless @repo_policy
    @repo_policy = JSON.parse(@repo_policy, { symbolize_names: true })
    @repo_policy = @repo_policy[:policyText]
    @repo_policy = JSON.parse(@repo_policy, { symbolize_names: true })
    statements = @repo_policy[:Statement].is_a?(Hash) ? [@repo_policy[:Statement]] : @repo_policy[:Statement]
    statement_match = []

    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    criteria[:Principal] = criteria[:Principal].is_a?(Array) ? criteria[:Principal].sort : criteria[:Principal]
    statements.each do |s|
      actions = s[:Action] || []
      puts actions
      effect = s[:Effect]
      puts effect
      principal = s[:Principal].is_a?(Array) ? s[:Principal].sort : s[:Principal]
      puts principal
      action_match = criteria[:Action].nil? ? true : actions.include?(criteria[:Action])
      # puts action_match
      effect_match = criteria[:Effect].nil? ? true : effect.eql?(criteria[:Effect])
      # puts effect_match
      principal_match = criteria[:Principal].nil? ? true : principal.eql?(criteria[:Principal])
      statement_match.nil? ? true: statement_match = statement_match.compact
      statement_match.push(action_match && effect_match && principal_match)
    end
    statement_match.include?(true)
  end

  def to_s
    "ECR Policy: #{@display_name} for #{@title_str} "
  end
end
