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

    unless opts[:detector_id].length.between?(1, 300)
      raise ArgumentError, "#{@__resource_name__}: 'detector_id' has a minimum character length of 1 and a maximum of 300"
    end
    @display_name = opts[:detector_id]

    catch_aws_errors do
      resp = @aws.guardduty_client.get_detector({ detector_id: opts[:detector_id] })
      if resp.first.nil?
        empty_response_warn
      else
        create_resource_methods(resp.first.to_h)
      end
    end
  end

  def exists?
    !failed_resource?
  end

  def enabled?
    status.upcase == 'ENABLED'
  end
end
