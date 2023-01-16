require "aws_backend"

class AWSEC2EIPAssociations < AwsResourceBase
  name "aws_ec2_eip_associations"
  desc "Describes the specified Elastic IP addresses or all of your Elastic IP addresses."

  example "
    describe aws_ec2_eip_associations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:association_ids, field: :association_id)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.compute_client.describe_addresses
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.addresses.map(&:to_h)
  end
end
