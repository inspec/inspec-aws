# frozen_string_literal: true

require 'aws_backend'

class AwsEcrImage < AwsResourceBase
  name 'aws_ecr_image'
  desc 'Verifies settings for an AWS ECR Image'

  example "
    describe aws_ecr_image(repository_name: 'my-repo', image_tag: 'latest') do
      it { should exist }
    end

    describe aws_ecr_image(repository_name: 'my-repo', image_digest: 'sha256:abc123...xyz') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(repository_name), require_any_of: %i(image_tag image_digest))
    @display_name = opts.values.join(' ')
    query_params = {
      repository_name: opts[:repository_name],
      image_ids: [
        opts.select { |k, _v| k.to_s.start_with?('image') },
      ],
    }
    catch_aws_errors do
      resp = @aws.ecr_client.describe_images(query_params)
      @image = resp.image_details.first.to_h
      create_resource_methods(@image)
    end
  end

  def exists?
    !@image.nil?
  end

  def vulnerabilities
    # Create an array of vulnerabilities identified in the image after a scan - @vulns.
    return unless exists?
    # Do not try to create if vulnerability data exists.
    return @vulns unless @vulns.nil?
    # Use describe_image_scan_findings method:
    # https://docs.aws.amazon.com/cli/latest/reference/ecr/describe-image-scan-findings.html
    query_params = {
      repository_name: @opts[:repository_name],
      image_id: @opts.select { |k, _v| k.to_s.start_with?('image') },
      max_results: 1000,
    }
    @scan_findings = []
    loop do
      catch_aws_errors do
        @resp = @aws.ecr_client.describe_image_scan_findings(query_params)
        @scan_findings += @resp.image_scan_findings.findings
      end
      # Return if AWS returned an error.
      return if @resp.nil?
      break unless @resp.next_token
      query_params[:next_token] = @resp[:next_token]
    end
    # Convert AWS struct format to hash.
    @vulns = []
    @scan_findings.each do |vuln|
      @vulns << vuln.to_h
    end
    # Extract :attributes returned in scan_findings:
    # :attributes=>[{:key=>"package_version", :value=>"1.1.18-r3"},
    # {:key=>"package_name", :value=>"musl"},
    # {:key=>"CVSS2_VECTOR", :value=>"AV:N/AC:L/Au:N/C:P/I:P/A:P"},
    # {:key=>"CVSS2_SCORE", :value=>"7.5"}],
    #
    # And, add them to the root vuln item as key:value pairs
    # :package_version=>"1.1.18-r3"
    # :package_name=>"musl"
    # :CVSS2_VECTOR=>"AV:N/AC:L/Au:N/C:P/I:P/A:P"
    # :CVSS2_SCORE=>"7.5"
    @vulns.each do |vuln|
      vuln[:attributes].each do |attr|
        vuln[attr[:key].to_sym] = attr[:value]
      end
      # Delete original :attributes item.
      vuln.delete(:attributes)
    end
    @vulns
  end

  def vulnerability_severity_counts
    image_scan_findings_summary.finding_severity_counts.item if @image.key?(:image_scan_findings_summary)
  end

  def to_s
    "ECR Image #{@display_name}"
  end
end
