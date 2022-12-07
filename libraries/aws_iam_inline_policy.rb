require 'aws_backend'

class AwsIamInlinePolicy < AwsResourceBase
  name 'aws_iam_inline_policy'
  desc 'Verifies settings for an Iam Inline Policy, attached to a user, role or group.'

  example "
    describe aws_iam_inline_policy(role_name: 'rolename-a', policy_name: 'policy-1') do
      it { should exist }
    end

    describe aws_iam_inline_policy(user_name: 'username-a', policy_name: 'policy-1') do
      it { should exist }
    end

    describe aws_iam_inline_policy(group_name: 'rolename-a', policy_name: 'policy-1') do
      it { should exist }
    end
  "

  attr_reader :policy_name, :policy_document, :user_name, :role_name, :group_name

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(role_name user_name group_name), required: %i(policy_name))

    @policy_name = opts[:policy_name]

    if opts.key?(:role_name)
      @role_name = opts[:role_name]
      @resp = get_role_policy_by_name(@role_name, @policy_name)
      @title_str =  "Role: #{@role_name}"
    elsif opts.key?(:group_name)
      @group_name = opts[:group_name]
      @resp = get_group_policy_by_name(@group_name, @policy_name)
      @title_str = "Group: #{@group_name}"
    elsif opts.key?(:user_name)
      @user_name = opts[:user_name]
      @resp = get_user_policy_by_name(@user_name, @policy_name)
      @title_str = "User: #{@user_name}"
    end

    @policy_document = @resp
  end

  def resource_id
    @policy_name
  end

  def get_role_policy_by_name(rolename, policyname)
    catch_aws_errors do
      @aws.iam_client.get_role_policy(role_name: rolename, policy_name: policyname)
    end
  end

  def get_group_policy_by_name(groupname, policyname)
    catch_aws_errors do
      @aws.iam_client.get_group_policy(group_name: groupname, policy_name: policyname)
    end
  end

  def get_user_policy_by_name(username, policyname)
    catch_aws_errors do
      @aws.iam_client.get_user_policy(user_name: username, policy_name: policyname)
    end
  end

  def exists?
    !@policy_document.nil?
  end

  def has_statement?(criteria = {})
    return false unless @policy_document
    document = JSON.parse(URI.decode_www_form_component(@policy_document.policy_document), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
    statement_match = []

    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    criteria[:Resource] = criteria[:Resource].is_a?(Array) ? criteria[:Resource].sort : criteria[:Resource]
    statements.each do |s|
      actions    = s[:Action] || []
      notactions = s[:NotAction] || []
      effect     = s[:Effect]
      resource   = s[:Resource].is_a?(Array) ? s[:Resource].sort : s[:Resource]

      action_match = if criteria[:Action].nil?
                       true
                     else
                       s[:Action].is_a?(Array) ? actions.include?(criteria[:Action]) : actions.eql?(criteria[:Action])
                     end

      no_action_match = if criteria[:NotAction].nil?
                          true
                        else
                          s[:NotAction].is_a?(Array) ? notactions.include?(criteria[:NotAction]) : notactions.eql?(criteria[:NotAction])
                        end

      effect_match = criteria[:Effect].nil? ? true : effect.eql?(criteria[:Effect])

      resource_match = criteria[:Resource].nil? ? true : resource.eql?(criteria[:Resource])

      statement_match.push(action_match && no_action_match && effect_match && resource_match)
    end
    statement_match.include?(true)
  end

  def statement_count
    return false unless @policy_document
    document = JSON.parse(URI.decode_www_form_component(@policy_document.policy_document), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
    statements.length
  end

  def to_s
    "AWS Inline Role Policy: #{@policy_name} for #{@title_str}"
  end
end
