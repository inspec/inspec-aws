require 'aws_backend'

class AwsGuardDutyDetectors < AwsResourceBase
  name 'aws_guardduty_detectors'
  desc 'Verifies settings for a Detector in bulk.'
  example "
    describe aws_guardduty_detectors do
      it { should exist }
    end
  "

  attr_reader :table, :detector_rows, :api_response

  FilterTable.create
             .register_column(:detector_ids, field: :detector_ids)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    detector_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.guardduty_client.list_detectors(pagination_options)
      end
      return detector_rows if !api_response || api_response.empty? || api_response.detector_ids.empty?
      detector_rows += [{ detector_ids: api_response.detector_ids }]
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = detector_rows
  end
end
