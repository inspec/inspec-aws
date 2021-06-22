# frozen_string_literal: true

require 'aws_backend'

class AWSServiceCatalogLaunchRoleConstraints < AwsResourceBase
  name 'aws_servicecatalog_launch_role_constraints'
  desc 'Gets information about the specified portfolio.'

  example "
    describe aws_servicecatalog_launch_role_constraints do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                           field: :id)
             .register_column(:arns,                                          field: :arn)
             .register_column(:display_names,                                 field: :display_name)
             .register_column(:descriptions,                                  field: :description)
             .register_column(:created_times,                                 field: :created_time)
             .register_column(:provider_names,                                field: :provider_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.servicecatalog_client.list_portfolios(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.portfolio_details.each do |resp|
        rows += [{ id: resp.id,
                   arn: resp.arn,
                   display_name: resp.display_name,
                   description: resp.description,
                   created_time: resp.created_time,
                   provider_name: resp.provider_name }]
      end
      break unless @api_response.next_page_token
      pagination_options = { next_page_token: @api_response.next_page_token }
    end
    @table = rows
  end
end
