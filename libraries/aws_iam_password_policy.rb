require "aws_backend"

class AwsIamPasswordPolicy < AwsResourceBase
  name "aws_iam_password_policy"
  desc "Verifies settings for an IAM Password Policy."

  example "
    describe aws_iam_password_policy do
      its('requires_lowercase_characters?') { should be true }
    end

    describe aws_iam_password_policy do
      its('requires_uppercase_characters?') { should be true }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters

    catch_aws_errors do
      @policy = @aws.iam_client.get_account_password_policy.password_policy
    end
  end

  def minimum_password_length
    return nil if !exists?
    @policy.minimum_password_length
  end

  def max_password_age_in_days
    return nil if !exists?
    raise "this policy does not expire passwords" unless expire_passwords?
    @policy.max_password_age
  end

  def number_of_passwords_to_remember
    return nil if !exists?
    raise "this policy does not prevent password reuse" \
      unless prevent_password_reuse?
    @policy.password_reuse_prevention
  end

  def prevent_password_reuse?
    return false if !exists? || @policy.password_reuse_prevention.nil?
    @policy.password_reuse_prevention > 0
  end

  RSpec::Matchers.alias_matcher :prevent_password_reuse, :be_prevent_password_reuse

  def expire_passwords?
    return false if !exists?
    @policy.max_password_age != 0
  end

  RSpec::Matchers.alias_matcher :expire_passwords, :be_expire_passwords

  def require_numbers?
    return false if !exists?
    @policy.require_numbers
  end

  RSpec::Matchers.alias_matcher :require_numbers, :be_require_numbers

  def require_symbols?
    return false if !exists?
    @policy.require_symbols
  end

  RSpec::Matchers.alias_matcher :require_symbols, :be_require_symbols

  def require_lowercase_characters?
    return false if !exists?
    @policy.require_lowercase_characters
  end

  RSpec::Matchers.alias_matcher :require_lowercase_characters, :be_require_lowercase_characters

  def require_uppercase_characters?
    return false if !exists?
    @policy.require_uppercase_characters
  end

  RSpec::Matchers.alias_matcher :require_uppercase_characters, :be_require_uppercase_characters

  def allow_users_to_change_password?
    return false if !exists?
    @policy.allow_users_to_change_password
  end

  RSpec::Matchers.alias_matcher :allow_users_to_change_password, :be_allow_users_to_change_password

  def exists?
    !@policy.nil?
  end

  def resource_id
    @policy
  end

  def to_s
    "AWS IAM Password Policy"
  end
end
