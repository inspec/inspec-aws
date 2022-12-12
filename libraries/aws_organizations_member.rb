require "aws_backend"

class AwsOrganizationsMember < AwsResourceBase
  name "aws_organizations_member"
  desc "Verifies status of the current AWWS Account within Organizations service."
  example "
    describe aws_organizations_member do
      it                       { should_not be_master }
      its('master_account_id') { should cmp '6525687452' }
    end
  "

  attr_reader :account_arn, :account_id, :account_email, :account_name, :master_account_id, :master_account_arn, :master

  alias master? master

  def initialize(opts = {})
    raise "Expected parameter opts to be a Hash." if !opts.nil? && !opts.is_a?(Hash)

    # Operations on Organizations must target us-east-1, see
    # https://docs.aws.amazon.com/organizations/latest/APIReference/Welcome.html
    opts[:aws_region] = "us-east-1"
    super(opts)
    validate_parameters

    catch_aws_errors do
      # Get Master Account details
      org = @aws.org_client.describe_organization.organization
      @master_account_id  = org.master_account_id
      @master_account_arn = org.master_account_arn

      begin
        # Get details of current Account
        account = @aws.org_client.describe_account(account_id: fetch_id).account
        @account_id    = account.id
        @account_arn   = account.arn
        @account_name  = account.name
        @account_email = account.email
      rescue
        @master = false
        return
      end

      # If we can retrieve both the Master Account and the current Account,
      # then the current Account is the Master Account.
      if @master_account_id && @account_id
        @master = true
      end
    end
  end

  def resource_id
    @account_arn
  end

  def exists?
    !@master_account_arn.nil?
  end

  def to_s
    "Organizations Member Status"
  end

  private

  # Fetch AWS Account Number
  def fetch_id
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[4]
  end
end
