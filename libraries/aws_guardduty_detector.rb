require "aws_backend"

class AwsGuardDutyDetector < AwsResourceBase
  name "aws_guardduty_detector"
  desc "Verifies settings for a Detector."
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
      @res = resp.to_h
      @created_at = @res[:created_at]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@res? @display_name: ""}_#{@res? @created_at: ""}"
  end

  def exists?
    !failed_resource?
  end

  def enabled?
    status.upcase == "ENABLED"
  end

  def to_s
    "Detector ID: #{@display_name}"
  end
end
