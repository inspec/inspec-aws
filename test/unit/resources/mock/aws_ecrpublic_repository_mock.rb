require_relative 'aws_base_resource_mock'

class AwsEcrPublicRepositoryMock < AwsBaseResourceMock

  def multiple(n)
    # Create multiple ECR repositories
    mocks = []
    n.times do
      mocks << {
          repository_arn: "arn:aws:ecr:us-east-1:510367013858:repository/inspec-test",
          registry_id: "477123926478",
          repository_name: "inspec-test",
          repository_uri: "477123926478.dkr.ecr.us-east-1.amazonaws.com/inspec-test",
          created_at: Time.parse(@aws.any_date.to_s),
      }
    end
    mocks.freeze
  end
end
