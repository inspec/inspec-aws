require_relative 'aws_base_resource_mock'

class AwsEfsFileSystemMock < AwsBaseResourceMock
  @@life_cycle = %w(creating available updating deleting deleted)
  @@performance_mode = %w(generalPurpose maxIO)
  @@encrypted = [true, false]
  @@throughput_mode = %w(bursting provisioned)

  attr_reader :mock

  def initialize
    super
    # Define required properties of a mock file system.

    @mock = {
        tags: [{ :key => @aws.any_string(4), :value => @aws.any_string }],
        file_system_id: "fs-#{@aws.any_hex}",
        creation_token: @aws.any_string,
        owner_id: @aws.any_int.to_s,
        creation_time: Time.parse(@aws.any_date.to_s),
        life_cycle_state: @@life_cycle.sample,
        number_of_mount_targets: @aws.any_int(1),
        size_in_bytes: { :value => @aws.any_int(4) },
        performance_mode: @@performance_mode.sample,
        encrypted: @@encrypted.sample,
        throughput_mode: @@throughput_mode.sample,
    }
  end
end
