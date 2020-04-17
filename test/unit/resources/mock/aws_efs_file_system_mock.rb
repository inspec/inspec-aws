require_relative 'aws_base_resource_mock'

class AwsEfsFileSystemMock < AwsBaseResourceMock
  LIFE_CYCLE = %w(creating available updating deleting deleted).freeze
  PERFORMANCE_MODE = %w(generalPurpose maxIO).freeze
  ENCRYPTED = [true, false].freeze
  THROUGHPUT_MODE = %w(bursting provisioned).freeze

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
        life_cycle_state: LIFE_CYCLE.sample,
        number_of_mount_targets: @aws.any_int(1),
        size_in_bytes: { :value => @aws.any_int(4) },
        performance_mode: PERFORMANCE_MODE.sample,
        encrypted: ENCRYPTED.sample,
        throughput_mode: THROUGHPUT_MODE.sample,
    }
  end
end
