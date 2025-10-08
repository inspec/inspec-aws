require "aws_backend"

class AWSEC2PrefixList < AwsResourceBase
  name "aws_ec2_prefix_list"
  desc "Describes your managed prefix lists and any Amazon Web Services-managed prefix lists."

  example "
    describe aws_ec2_prefix_list(prefix_list_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { prefix_list_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:prefix_list_id])
    unless opts[:prefix_list_id] && !opts[:prefix_list_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: prefix_list_id must be provided"
    end
    @display_name = opts[:prefix_list_id]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_managed_prefix_lists(
          { prefix_list_ids: [opts[:prefix_list_id]] }
        )
      @res = resp.prefix_lists[0].to_h
      create_resource_methods(@res)
    end
  end

  def prefix_list_id
    return nil unless exists?
    @res[:prefix_list_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:prefix_list_id] : @display_name
  end

  def to_s
    "Prefix List ID: #{@display_name}"
  end
end
