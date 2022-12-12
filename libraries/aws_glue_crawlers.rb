require "aws_backend"

class AWSGlueCrawlers < AwsResourceBase
  name "aws_glue_crawlers"
  desc "Retrieves metadata for all crawlers defined in the customer account."

  example "
    describe aws_glue_crawlers do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:names,                                       field: :name)
    .register_column(:roles,                                       field: :role)
    .register_column(:targets,                                     field: :targets)
    .register_column(:database_names,                              field: :database_name)
    .register_column(:descriptions,                                field: :description)
    .register_column(:classifiers,                                 field: :classifiers)
    .register_column(:recrawl_policies,                            field: :recrawl_policy)
    .register_column(:schema_change_policies,                      field: :schema_change_policy)
    .register_column(:states,                                      field: :state)
    .register_column(:table_prefixes,                              field: :table_prefix)
    .register_column(:schedules,                                   field: :schedule)
    .register_column(:crawl_elapsed_times,                         field: :crawl_elapsed_time)
    .register_column(:creation_times,                              field: :creation_time)
    .register_column(:last_updated,                                field: :last_updated)
    .register_column(:last_crawls,                                 field: :last_crawl)
    .register_column(:versions,                                    field: :version)
    .register_column(:configurations,                              field: :configuration)
    .register_column(:crawler_security_configuration,              field: :crawler_security_configuration)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.glue_client.get_crawlers(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.crawlers.each do |res|
        rows += [{
          name: res.name,
          role: res.role,
          targets: res.targets,
          database_name: res.database_name,
          description: res.description,
          classifiers: res.classifiers,
          recrawl_policy: res.recrawl_policy,
          schema_change_policy: res.schema_change_policy,
          state: res.state,
          table_prefix: res.table_prefix,
          schedule: res.schedule,
          crawl_elapsed_time: res.crawl_elapsed_time,
          creation_time: res.creation_time,
          last_updated: res.last_updated,
          last_crawl: res.last_crawl,
          versions: res.version,
          configuration: res.configuration,
          crawler_security_configuration: res.crawler_security_configuration,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
