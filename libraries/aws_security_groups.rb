require "aws_backend"

class AwsSecurityGroups < AwsCollectionResourceBase
  name "aws_security_groups"
  desc "Verifies settings for AWS Security Groups in bulk."
  example "
    # Verify that you have security groups defined
    describe aws_security_groups do
      it { should exist }
    end

    # Verify you have more than the default security group
    describe aws_security_groups do
      its('entries.count') { should be > 1 }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :compute_client, operation: :describe_security_groups).security_groups.map(&:to_h)
    populate_filter_table_from_response
  end
end
