# frozen_string_literal: true

require 'aws_backend'

class AWSServiceCatalogCloudFormationProducts < AwsResourceBase
  name 'aws_servicecatalog_cloud_formation_products'
  desc 'Gets information about the specified product.'

  example "
    describe aws_servicecatalog_cloud_formation_products do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                           field: :id)
             .register_column(:product_ids,                                   field: :product_id)
             .register_column(:names,                                         field: :name)
             .register_column(:owners,                                        field: :owner)
             .register_column(:short_descriptions,                            field: :short_description)
             .register_column(:types,                                         field: :type)
             .register_column(:distributors,                                  field: :distributor)
             .register_column(:has_default_paths,                             field: :has_default_path)
             .register_column(:support_emails,                                field: :support_email)
             .register_column(:support_descriptions,                          field: :support_description)
             .register_column(:support_urls,                                  field: :support_url)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    # super(opts)
    # validate_parameters(require_any_of: %i(name id))
    # @query_params = {}
    # @query_params[:name] = opts[:name]
    # raise ArgumentError, "#{@__resource_name__}: name must be provided" unless opts[:name] && !opts[:name].empty?
    # @query_params[:name] = opts[:name]
    # @table = fetch_data
    #
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:page_size] = 20
    loop do
      catch_aws_errors do
        @api_response = @aws.servicecatalog_client.search_products(@query_params)
      end
      return rows if !@api_response || @api_response.empty?

      @api_response.product_view_summaries.each do |resp|
        rows += [{ id: resp.id,
                   product_id: resp.product_id,
                   name: resp.name,
                   owner: resp.owner,
                   short_description: resp.short_description,
                   type: resp.type,
                   distributor: resp.distributor,
                   has_default_path: resp.has_default_path,
                   support_email: resp.support_email,
                   support_description: resp.support_description,
                   support_url: resp.support_url }]
      end
      break unless @api_response.next_page_token
      @query_params[:page_token] = @api_response.next_page_token
    end
    @table = rows
  end
end
