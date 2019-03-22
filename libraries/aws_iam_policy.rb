# frozen_string_literal: true

require 'aws_backend'

class AwsIamPolicy < AwsResourceBase
  name 'aws_iam_policy'
  desc 'Verifies settings for an Iam Policy'

  example "
    describe aws_iam_policy('policy-1') do
      it { should exist }
    end
  "

  attr_reader :arn, :attachment_count, :default_version_id, :policy_name, :policy_id, :attached_groups,
              :attached_roles, :attached_users, :policy_document

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(policy_arn policy_name))

    if opts.key?(:policy_arn)
      @resp = get_policy_by_arn(opts[:policy_arn])
    elsif opts.key?(:policy_name)
      @resp = get_policy_by_name(opts[:policy_name])
    end

    get_attached_entities(@resp.arn)
    get_policy_document(@resp.arn, @resp.default_version_id)

    @arn = @resp.arn
    @policy_name = @resp.policy_name
    @policy_id = @resp.policy_id
    @attachment_count = @resp.attachment_count
    @default_version_id = @resp.default_version_id
  end

  # Required to maintain compatibility with previous implementation
  def get_policy_by_name(policy_name)
    policy = nil
    catch_aws_errors do
      pagination_opts = {}
      loop do
        response = @aws.iam_client.list_policies(pagination_opts)
        policy = response.policies.detect { |p| p.policy_name == policy_name }
        break if policy
        break unless response.is_truncated
        pagination_opts[:marker] = response.marker
      end
    end
    policy
  end

  def get_policy_by_arn(arn)
    catch_aws_errors do
      @aws.iam_client.get_policy({ policy_arn: arn }).policy
    end
  end

  def get_attached_entities(arn)
    criteria = { policy_arn: arn }
    resp = nil
    catch_aws_errors do
      resp = @aws.iam_client.list_entities_for_policy(criteria)
    end
    @attached_groups = resp.policy_groups.map(&:group_name)
    @attached_users  = resp.policy_users.map(&:user_name)
    @attached_roles  = resp.policy_roles.map(&:role_name)
  end

  def exists?
    !@arn.nil?
  end

  def has_statement?(criteria = {})
    return false unless @policy_document
    document = JSON.parse(URI.decode_www_form_component(@policy_document.policy_version.document), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
    statement_match = false
    statements.each do |s|
      actions  = s[:Action]
      effect   = s[:Effect]
      resource = s[:Resource]
      statement_match = true if actions.include?(criteria['Action']) && effect.eql?(criteria['Effect']) && resource.eql?(criteria['Resource'])
    end
    statement_match
  end

  def statement_count
    return false unless @policy_document
    document = JSON.parse(URI.decode_www_form_component(@policy_document.policy_version.document), { symbolize_names: true })
    statements = document[:Statement].is_a?(Hash) ? [document[:Statement]] : document[:Statement]
    statements.length
  end

  def get_policy_document(arn, default_version_id)
    catch_aws_errors do
      @policy_document = @aws.iam_client.get_policy_version(policy_arn: arn, version_id: default_version_id)
    end
  end

  def to_s
    "AWS Iam Policy #{@policy_name}"
  end
end
