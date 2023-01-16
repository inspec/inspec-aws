require "aws_backend"

class AwsEfsFileSystems < AwsResourceBase
  name "aws_efs_file_systems"
  desc "Verifies settings for a collection of AWS EFS File Systems."
  example "
    describe aws_efs_file_systems do
      its('count') { should eq 3 }
    end

    # Iterate through all file systems
    aws_efs_file_systems.file_system_ids.each do |file_system_id|
      describe aws_efs_file_system(file_system_id) do
        its('tags') { should include('companyName' => 'My Company Name') }
        it { should be_encrypted }
        its('throughput_mode') { should eq 'bursting' }
      end
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:tags, field: :tags)
    .register_column(:file_system_ids, field: :file_system_id)
    .register_column(:creation_tokens, field: :creation_token)
    .register_column(:owner_ids, field: :owner_id)
    .register_column(:creation_times, field: :creation_time)
    .register_column(:performance_modes, field: :performance_mode)
    .register_column(:encryption_status, field: :encrypted)
    .register_column(:throughput_modes, field: :throughput_mode)
    .register_column(:kms_key_ids, field: :kms_key_id)
    .register_column(:size_in_bytes, field: :size_in_bytes)
    .register_column(:life_cycle_states, field: :life_cycle_state)
    .register_column(:names, field: :name)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    efs_file_system_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.efs_client.describe_file_systems(**pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.file_systems.each do |file_system|
        efs_file_system_rows += [{
          tags: file_system.tags,
          file_system_id: file_system.file_system_id,
          creation_token: file_system.creation_token,
          owner_id: file_system.owner_id,
          creation_time: file_system.creation_time,
          performance_mode: file_system.performance_mode,
          encrypted: file_system.encrypted,
          throughput_mode: file_system.throughput_mode,
          kms_key_id: file_system.kms_key_id,
          size_in_bytes: file_system.size_in_bytes,
          life_cycle_state: file_system.life_cycle_state,
          name: file_system.name,
        }]
      end
      break unless @api_response.next_marker
      pagination_options = { marker: @api_response[:next_marker] }
    end
    efs_file_system_rows
  end
end
