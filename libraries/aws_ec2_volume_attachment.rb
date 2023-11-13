require 'aws_backend'

class AWSEC2VolumeAttachment < AwsResourceBase
  name 'aws_ec2_volume_attachment'
  desc 'Describes the specified EBS volumes attachments or all of your EBS volumes attachments.'

  example "
    describe aws_ec2_volume_attachment(volume_id: 'VolumeID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { volume_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:volume_id])
    raise ArgumentError, "#{@__resource_name__}: volume_id must be provided" unless opts[:volume_id] && !opts[:volume_id].empty?
    @display_name = opts[:volume_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_volumes({ volume_ids: [opts[:volume_id]] })
      @res = resp.volumes[0].attachments[0].to_h
      create_resource_methods(@res)
    end
  end

  def volume_id
    return unless exists?
    @res[:volume_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:volume_id] : @display_name
  end

  def to_s
    "Volume ID: #{@display_name}"
  end
end
