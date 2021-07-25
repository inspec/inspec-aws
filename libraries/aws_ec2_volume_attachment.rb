# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VolumeAttachtment < AwsResourceBase
  name 'aws_ec2_volume_attachment'
  desc 'Describes EC2 volume attachment.'

  example "
    describe aws_ec2_volume_attachment('vol-12345678') do
      it { should exist }
      its ('state') { should eq 'attached' }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(volume_id name))

    if opts[:volume_id] && !opts[:volume_id].empty?
      raise ArgumentError, "#{@__resource_name__}:  must be in the format 'vol- followed by 8 or 17 hexadecimal characters." if opts[:volume_id] !~ /^vol\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
      @display_name = opts[:volume_id]
      volume_arguments = { volume_ids: [opts[:volume_id]] }
    elsif opts[:name] && !opts[:name].empty?
      @display_name = opts[:name]
      filter = { name: 'tag:Name', values: [opts[:name]] }
      volume_arguments = { filters: [filter] }
    else
      raise ArgumentError, "#{@__resource_name__}:  `volume_id` or `name` must be provided"
    end

    catch_aws_errors do
      resp = @aws.compute_client.describe_volumes(volume_arguments)
      @volume = resp.volumes[0].attachments[0].to_h
    end
    create_resource_methods(@volume)
  end

  def volume_id
    return nil unless exists?
    @volume[:volume_id]
  end

  def exists?
    !@volume.nil? && !@volume.empty?
  end

  def to_s
    "Volume ID: #{@display_name}"
  end
end
