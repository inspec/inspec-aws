require 'aws_backend'

class AWSEC2EIPAssociation < AwsResourceBase
  name 'aws_ec2_eip_association'
  desc 'Describes the specified Elastic IP addresses or all of your Elastic IP addresses.'

  example "
    describe aws_ec2_eip_association(association_id: 'ASSOCIATION_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { association_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(association_id))
    raise ArgumentError, "#{@__resource_name__}: association_id must be provided" unless opts[:association_id] && !opts[:association_id].empty?
    filter = [
      {
        name: 'association-id',
        values: [opts[:association_id]],
      },
    ]
    @display_name = opts[:association_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_addresses({ filters: filter })
      @resp = resp.addresses[0].to_h
      create_resource_methods(@resp)
    end
  end

  def association_id
    return nil unless exists?
    @resp[:association_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @resp ? @resp[:association_id] : @display_name
  end

  def to_s
    "Association Id: #{@display_name}"
  end
end
