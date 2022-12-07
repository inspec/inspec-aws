require 'aws_backend'

class AWSRAMResourceShares < AwsResourceBase
  name 'aws_ram_resource_shares'
  desc 'Lists the resources that you added to a resource shares or the resources that are shared with you.'

  example "
    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:resource_share_arns,                         field: :resource_share_arn)
             .register_column(:names,                                       field: :name)
             .register_column(:owning_account_ids,                          field: :owning_account_id)
             .register_column(:allow_external_principals,                   field: :allow_external_principals)
             .register_column(:statuses,                                    field: :status)
             .register_column(:status_messages,                             field: :status_message)
             .register_column(:tags,                                        field: :tags)
             .register_column(:creation_times,                              field: :creation_time)
             .register_column(:last_updated_times,                          field: :last_updated_time)
             .register_column(:feature_sets,                                field: :feature_set)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(resource_owner))
    @query_params = {}
    @query_params[:resource_owner] = opts[:resource_owner]
    if opts.key?(:resource_owner)
      raise ArgumentError, "#{@__resource_name__}: resource_owner must be provided" unless opts[:resource_owner] && !opts[:resource_owner].empty?
      @query_params[:resource_owner] = opts[:resource_owner]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 10
    loop do
      catch_aws_errors do
        @api_response = @aws.ram_client.get_resource_shares(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.resource_shares.each do |res|
        rows += [{ resource_share_arn: res.resource_share_arn,
                   name: res.name,
                   owning_account_id: res.owning_account_id,
                   allow_external_principals: res.allow_external_principals,
                   status: res.status,
                   status_message: res.status_message,
                   tags: res.tags,
                   creation_time: res.creation_time,
                   last_updated_time: res.last_updated_time,
                   feature_set: res.feature_set }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
