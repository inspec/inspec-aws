require_relative 'aws_base_resource_mock'

class AwsStsCallerIdentityMock < AwsBaseResourceMock

  def initialize
    super

    @sts = {
        account: @aws.any_string,
        arn: @aws.any_arn,
        user_id: @aws.any_string,
    }
  end

  def stub_data(is_govcloud)
    stub_data = []

    @sts[:arn] = @aws.any_arn({ partition: 'aws-us-gov' }) if is_govcloud

    sts = { :client => Aws::STS::Client,
            :method => :get_caller_identity,
            :data => @sts }

    stub_data += [sts]
  end

  def identity
    @sts
  end

end