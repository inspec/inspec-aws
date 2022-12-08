require "aws_backend"

class AwsEcrPolicy < AwsResourceBase
  name "aws_ecr_repository_policy"
  desc "Verifies policy settings for an AWS ECR Repository."

  example "
    describe aws_ecr_repository_policy(repository_name: 'my-repository') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    # Create a repository_name:<value> pair if the argument is a string object.
    opts = { repository_name: opts } if opts.is_a?(String)

    super(opts)
    validate_parameters(required: %i(repository_name))
    @repo_name = { "repository_name": opts[:repository_name] }
    @display_name = opts[:repository_name]
    catch_aws_errors do
      resp = @aws.ecr_client.get_repository_policy(@repo_name)
      @repo_policy = resp.policy_text
      @repository_name = resp.repository_name
      @registry_id = resp.registry_id
    end
  end

  def resource_id
    "#{@repository_name}_#{@registry_id}"
  end

  def exists?
    !@repo_policy.nil? && !@repo_policy.empty?
  end

  def has_statement?(criteria = {})
    return false unless @repo_policy
    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    criteria[:Principal] = criteria[:Principal].is_a?(Array) ? criteria[:Principal].sort : criteria[:Principal]
    statements.any? do |s|
      actions = s[:Action] || []
      effect = s[:Effect]
      sid = s[:Sid]
      principal = s[:Principal].is_a?(Array) ? s[:Principal].sort : s[:Principal]
      action_match = criteria[:Action].nil? ? true : actions.include?(criteria[:Action])
      effect_match = criteria[:Effect].nil? ? true : effect.eql?(criteria[:Effect])
      sid_match = criteria[:Sid].nil? ? true : sid.eql?(criteria[:Sid])
      principal_match = criteria[:Principal].nil? ? true : principal.eql?(criteria[:Principal])
      (action_match && effect_match && sid_match && principal_match)
    end
  end

  def to_s
    "ECR Policy for #{@repo_name}"
  end

  private

  def statements
    @statements ||= calculate_statements || []
  end

  def calculate_statements
    return unless @repo_policy

    document_string = @repo_policy
    document = JSON.parse(document_string, symbolize_names: true)
    document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
  end
end
