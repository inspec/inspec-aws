# frozen_string_literal: true

require 'aws_backend'

class AwsEbsVolume < AwsResourceBase
  name 'aws_ebs_volume'
  desc 'Verifies settings for an EBS volume'

  example "
    describe aws_ebs_volume('vol-12345678') do
      it { should be_encrypted }
      its('size') { should cmp 8 }
    end

    describe aws_ebs_volume(name: 'my-volume') do
      its('encrypted') { should eq true }
      its('iops') { should cmp 100 }
    end
  "

  def initialize(opts = {})
    raise ArgumentError, 'aws_ebs_volume `id` or `name` must be provided' if opts.nil?
    opts = { volume_id: opts } if opts.is_a?(String) # this preserves the original scalar interface - note that the original implementation offered scalar 'id' or tag property :name
    # Call the parent class constructor
    super(opts)
    validate_parameters(%i(volume_id name))
    @display_name = opts[:volume_id] || opts[:name]
    if opts[:volume_id] && !opts[:volume_id].empty?
      raise ArgumentError, 'aws_ebs_volume must be in the format "vol-" followed by 8 or 17 hexadecimal characters.' if opts[:volume_id] !~ /^vol\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
      volume_arguments = { volume_ids: [opts[:volume_id]] }
    else
      raise ArgumentError, 'aws_ebs_volume `name` must be provided' if opts[:name].nil? || opts[:name].empty?
      filter = { name: 'tag:Name', values: [opts[:name]] }
      volume_arguments = { filters: [filter] }
    end

    catch_aws_errors do
      @resp = @aws.compute_client.describe_volumes(volume_arguments)
      @volume = @resp.volumes[0].to_h
      create_resource_methods(@volume)
      # below is because the original implementation exposed several clashing method
      # names and we want to ensure backwards compatibility
      class << self
        def tags
          @volume[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def id
    return nil if !exists?
    @volume[:volume_id]
  end

  def exists?
    return false if @volume.nil?
    !@volume.empty?
  end

  def encrypted?
    @volume[:encrypted]
  end

  def to_s
    "EBS Volume #{@display_name}"
  end
end
