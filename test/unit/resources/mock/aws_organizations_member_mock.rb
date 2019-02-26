require_relative 'aws_base_resource_mock'

class AwsOrganizationsMemberMock < AwsBaseResourceMock

  def initialize
    super

    account_id  = @aws.any_string
    account_arn = @aws.any_arn

    @current_account = {
        account: {
            id: account_id,
            arn: account_arn,
            name: @aws.any_string,
            email: @aws.any_email,
        },
    }

    @org = {
        organization: {
            arn: @aws.any_arn,
            available_policy_types: [
                {
                    status: "ENABLED",
                    type: "SERVICE_CONTROL_POLICY",
                },
            ],
            feature_set: "ALL",
            id: @aws.any_string,
            master_account_arn: account_arn,
            master_account_email: @aws.any_email,
            master_account_id: account_id
        },
    }

    @sts = {
        account: account_id,
        arn: @aws.any_arn,
        user_id: @aws.any_string,
    }
  end

  def stub_data(is_master_account)
    stub_data = []

    org = { :client => Aws::Organizations::Client,
                :method => :describe_organization,
                :data => @org }

    is_master_account ? response = @current_account
                      : response = Aws::Organizations::Errors::AccessDeniedException.new(nil,nil)

    ca  = { :client => Aws::Organizations::Client,
            :method => :describe_account,
            :data => response }

    sts = { :client => Aws::STS::Client,
            :method => :get_caller_identity,
            :data => @sts }

    stub_data += [org]
    stub_data += [ca]
    stub_data += [sts]
  end

  def organization
    @org[:organization]
  end

  def account
    @current_account[:account]
  end

end