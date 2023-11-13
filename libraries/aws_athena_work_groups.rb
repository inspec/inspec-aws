require 'aws_backend'

class AWSAthenaWorkGroups < AwsResourceBase
  name 'aws_athena_work_groups'
  desc 'Lists available workgroups for the account.'
  example <<-EXAMPLE
    describe aws_athena_work_groups do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:names,                         field: :name)
             .register_column(:states,                        field: :state)
             .register_column(:descriptions,                  field: :description)
             .register_column(:creation_times,                field: :creation_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    work_groups_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.athena_client.list_work_groups(pagination_options)
      end
      return work_groups_rows if !@api_response || @api_response.empty?
      @api_response.work_groups.each do |work_group|
        work_groups_rows += [{
          name: work_group.name,
          state: work_group.state,
          description: work_group.description,
          creation_time: work_group.creation_time,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = work_groups_rows
  end
end
