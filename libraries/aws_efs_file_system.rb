require 'aws_backend'

class AwsEfsFileSystem < AwsResourceBase
  name 'aws_efs_file_system'
  desc 'Verifies settings for an EFS File System.'

  example "
    describe aws_efs_file_system('fs-12345678') do
      it                         { should be_encrypted }
      its('size_in_bytes.value') { should cmp 6144 }
    end

    describe aws_efs_file_system(creation_token: 'my-token') do
      its('encrypted')       { should cmp true }
      its('throughput_mode') { should eq 'bursting' }
    end
  "

  def initialize(opts = {})
    # Assume the argument is a file_system_id when it is a string type object and reject any other type.
    opts = { file_system_id: opts } if opts.is_a?(String)
    opts = {} unless opts.is_a?(Hash)

    # File system identifier can be either the file_system_id or the creation_token.
    if opts.key?(:file_system_id)
      raise ArgumentError, "#{@__resource_name__}: file_system_id must be in the format 'fs-' followed by 8 or 17 hexadecimal characters." unless /^fs\-([0-9a-f]{8})|(^fs\-[0-9a-f]{17})$/.match?(opts[:file_system_id])
      file_system_arguments = { file_system_id: opts[:file_system_id] }
    elsif opts.key?(:creation_token)
      raise ArgumentError, "#{@__resource_name__}: creation_token must be minimum 1 and maximum 64-character long." unless opts[:creation_token].length.between?(1, 64)
      file_system_arguments = { creation_token: opts[:creation_token] }
    else
      raise ArgumentError, "#{@__resource_name__}:  `file_system_id` or `creation_token` must be provided."
    end

    super(opts)
    # file_system_arguments has a single item.
    validate_parameters(required: [file_system_arguments.keys.first])
    @display_name = file_system_arguments.values.first

    # Ensure the response will have a single file system description.
    file_system_arguments[:max_items] = 1

    catch_aws_errors do
      begin
        resp = @aws.efs_client.describe_file_systems(file_system_arguments)
        @file_system = resp.file_systems.first.to_h
        # Invalid creation_token returns empty file_system_description.
        if @file_system.empty?
          # This is equal to FileSystemNotFound exception in this context.
          raise Aws::EFS::Errors::FileSystemNotFound.new(resp, "#{@__resource_name__} not found.")
        end
      rescue Aws::EFS::Errors::FileSystemNotFound
        return
      end
      create_resource_methods(@file_system)
    end
  end

  def id
    @file_system[:file_system_id] || nil
  end

  def tags
    map_tags(@file_system[:tags])
  end

  def exists?
    !@file_system.nil? && !@file_system.empty?
  end

  def encrypted?
    @file_system[:encrypted]
  end

  def resource_id
    @file_system[:file_system_id]
  end

  def to_s
    "EFS File System #{@display_name}"
  end
end
