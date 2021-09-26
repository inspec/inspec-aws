# frozen_string_literal: true

require 'aws_backend'

class AWSSignerSigningProfiles < AwsResourceBase
  name 'aws_signer_signing_profiles'
  desc 'Returns information on a specific signing profile.'

  example "
    describe aws_signer_signing_profiles do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:profile_names, field: :profile_name)
             .register_column(:profile_versions, field: :profile_version)
             .register_column(:profile_version_arns, field: :profile_version_arn)
             .register_column(:signing_materials, field: :signing_material)
             .register_column(:signature_validity_periods, field: :signature_validity_period)
             .register_column(:platform_ids, field: :platform_id)
             .register_column(:platform_display_names, field: :platform_display_name)
             .register_column(:signing_parameters, field: :signing_parameters)
             .register_column(:statuses, field: :status)
             .register_column(:arns, field: :arn)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.signer_client.list_signing_profiles(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.profiles.each do |resp|
        rows += [{ profile_name: resp.profile_name,
                   profile_version: resp.profile_version,
                   profile_version_arn: resp.profile_version_arn,
                   signature_validity_period: resp.signature_validity_period,
                   platform_id: resp.platform_id,
                   platform_display_name: resp.platform_display_name,
                   signing_parameters: resp.signing_parameters,
                   status: resp.status,
                   arn: resp.arn,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
