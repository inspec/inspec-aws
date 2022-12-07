require 'aws_backend'

class AwsEbsVolume < AwsResourceBase
  name 'aws_ebs_volume'
  desc 'Verifies settings for an EBS volume.'

  example "
    describe aws_ebs_volume('vol-12345678') do
      it          { should be_encrypted }
      its('size') { should cmp 8 }
    end

    describe aws_ebs_volume(name: 'my-volume') do
      its('encrypted') { should eq true }
      its('iops')      { should cmp 100 }
    end
  "

  def initialize(opts = {})
    opts = { volume_id: opts } if opts.is_a?(String)
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
      @volume = resp.volumes[0].to_h

      create_resource_methods(@volume)

      # Methods required to ensure backwards compatibility
      class << self
        def tags
          @volume[:tags].map { |tag| { key: tag[:key], value: tag[:value] } }
        end
      end
    end
  end

  def id
    return nil unless exists?
    @volume[:volume_id]
  end

  def exists?
    !@volume.nil? && !@volume.empty?
  end

  def encrypted?
    @volume[:encrypted]
  end

  def resource_id
    @volume ? @volume[:volume_id] : @display_name
  end

  def to_s
    "EBS Volume #{@display_name}"
  end
end
