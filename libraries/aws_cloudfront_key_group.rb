require 'aws_backend'

class AwsCloudFrontKeyGroup < AwsResourceBase
  name 'aws_cloudfront_key_group'
  desc 'Describes one Key Group.'
  example <<-EXAMPLE
    describe aws_cloudfront_key_group(id: 'KEY_GROUP_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:id])
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.cloudfront_client.get_key_group({ id: opts[:id] })
      @resp = resp.key_group.to_h
      create_resource_methods(@resp)
    end
  end

  def resource_id
    @resp? @resp[:id]: @display_name
  end

  def id
    return unless exists?
    @resp[:id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Key Group ID: #{@display_name}"
  end
end
