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
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.servicecatalog_client.describe_product
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.product_view_summary.map(&:to_h)
  end
end
