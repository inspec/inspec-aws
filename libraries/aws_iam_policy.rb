require "aws_backend"

class AwsIamPolicy < AwsResourceBase
  name "aws_iam_policy"
  desc "Verifies settings for an IAM Policy."

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
      @policy_name = opts[:policy_arn]
      @resp = get_policy_by_arn(opts[:policy_arn])
    elsif opts.key?(:policy_name)
      @policy_name = opts[:policy_name]
      @resp = get_policy_by_name(opts[:policy_name])
    end

    return if @resp.nil?
    get_attached_entities(@resp.arn)
    get_policy_document(@resp.arn, @resp.default_version_id)

    @arn = @resp.arn
    @policy_name = @resp.policy_name
    @policy_id = @resp.policy_id
    @attachment_count = @resp.attachment_count
    @default_version_id = @resp.default_version_id
  end

  def resource_id
    @arn
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

  def attached_to_user?(username)
    !@attached_users.nil? && @attached_users.include?(username)
  end

  def attached_to_role?(rolename)
    !@attached_roles.nil? && @attached_roles.include?(rolename)
  end

  def exists?
    !@arn.nil?
  end

  def has_statement?(criteria = {})
    return false unless @policy_document
    document = JSON.parse(URI.decode_www_form_component(@policy_document.policy_version.document), { symbolize_names: true })
    statements = document[:Statement].is_a?(Array) ? document[:Statement] : [document[:Statement]].compact
    # downcase keys to eliminate formatting issue
    # put values in an array for standard match checking
    criteria = criteria.each_with_object({}) { |(k, v), h| h[k.downcase.to_sym] = v.is_a?(Array) ? v : [v] }
    return false if criteria.empty? || statements.empty?
    # Principal and Conditional are not supported.
    # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
    allowed_statement_elements = %i(Action Effect Sid Resource NotAction NotResource)
    # downcase keys to eliminate formatting issue
    unless criteria.keys.all? { |k| allowed_statement_elements.map(&:downcase).include?(k) }
      raise ArgumentError, "Valid statement elements are #{allowed_statement_elements}, provided elements are: #{criteria.keys}"
    end
    # puts "Criteria #{criteria}"
    statements.each do |statement|
      # This is to comply with the document that allowing keys in lowercase format.
      statement = statement.each_with_object({}) { |(k, v), acc| acc[k.downcase] = v }
      @statement_match = false
      criteria_match = []
      criteria.each do |k_c, v_c|
        criteria_match << v_c.all? do |v|
          statement_item_in_array = statement[k_c].is_a?(Array) ? statement[k_c] : [statement[k_c]].compact
          statement_item_in_array.include?(v)
        end
      end
      if criteria_match.all?(true)
        @statement_match = true
      end
      break if criteria_match.all?(true)
    end
    @statement_match
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
