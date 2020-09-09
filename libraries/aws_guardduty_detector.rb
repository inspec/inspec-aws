# frozen_string_literal: true

require 'aws_backend'

class AwsGuardDutyDetector < AwsResourceBase
  name 'aws_guardduty_detector'
  desc 'Verifies settings for a Detector'
  example "
    describe aws_guardduty_detector(detector_id: 'detector-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { detector_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:detector_id])
    @display_name = opts[:detector_id]

    catch_aws_errors do
      resp = @aws.guardduty_client.get_detector({ detector_id: opts[:detector_id] })
      if resp.first.nil?
        empty_response_warn
      else
        detector = resp.first.to_h
        create_resource_methods(detector)
      end
    end
  end

  def exists?
    !failed_resource?
  end

end
