# frozen_string_literal: true

require 'aws_backend'

class AwsSecurityGroups < AwsCollectionResourceBase
  name 'aws_security_groups'
  desc 'Verifies settings for AWS Security Groups in bulk.'
  example "
    describe aws_security_groups do
      it { should exist } # Verify that you have security groups defined
      its('entries.count') { should be > 1 } # Verify you have more than the default security group
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :compute_client, operation: :describe_security_groups).security_groups.map(&:to_h)
    populate_filter_table_from_response
  end
end
