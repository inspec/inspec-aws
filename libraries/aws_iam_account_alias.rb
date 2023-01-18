class AwsIamAccountAlias < AwsResourceBase
  name "aws_iam_account_alias"
  desc "Verifies settings for an AWS IAM Account Alias."
  example "
    describe aws_iam_account_alias do
      it { should exist }
      its('alias') { should match /^fancy-/ }
    end
  "
  supports platform: "aws"

  attr_reader :alias

  def initialize(opts = {})
    super(opts)
    validate_parameters

    catch_aws_errors do
      # Note, although this is an array, you can only have one account alias
      # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/IAM/Client.html#list_account_aliases-instance_method
      @alias = @aws.iam_client.list_account_aliases.account_aliases[0]
    end
  end

  def resource_id
    @alias
  end

  def exists?
    !@alias.nil?
  end

  def to_s
    "AWS IAM Account Alias #{@alias}"
  end
end
