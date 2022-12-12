require "aws_backend"

class AWSWAFIPSet < AwsResourceBase
  name "aws_waf_ip_set"
  desc "Describes one WAF IP set."

  example "
    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { ip_set_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(ip_set_id))
    raise ArgumentError, "#{@__resource_name__}: ip_set_id must be provided" unless opts[:ip_set_id] && !opts[:ip_set_id].empty?
    @display_name = opts[:ip_set_id]
    catch_aws_errors do
      resp = @aws.waf_client.get_ip_set({ ip_set_id: opts[:ip_set_id] })
      @resp = resp.ip_set.to_h
      create_resource_methods(@resp)
    end
  end

  def ip_set_id
    return nil unless exists?
    @resp[:ip_set_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "IP Set ID: #{@display_name}"
  end

  def ip_set_descriptors_types
    ip_set_descriptors.map(&:type)
  end

  def ip_set_descriptors_values
    ip_set_descriptors.map(&:value)
  end

  def resource_id
    @display_name
  end
end
