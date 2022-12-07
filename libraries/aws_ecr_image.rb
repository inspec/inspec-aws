require 'aws_backend'

class AwsEcrImage < AwsResourceBase
  name 'aws_ecr_image'
  desc 'Verifies settings for an AWS ECR Image.'

  example "
    describe aws_ecr_image(repository_name: 'my-repo', image_tag: 'latest') do
      it { should exist }
    end

    describe aws_ecr_image(repository_name: 'my-repo', image_digest: 'sha256:abc123...edf') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(repository_name), require_any_of: %i(image_tag image_digest), allow: %i(registry_id))
    @display_name = opts.values.join(' ')

    # Validate repository_name.
    pattern = %r{(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._\-][a-z0-9]+)*}
    matched_str = opts[:repository_name].match(pattern)
    unless (opts[:repository_name] == matched_str[0]) && (matched_str.length == 1) && opts[:repository_name].length.between?(2, 256)
      raise ArgumentError, "#{@__resource_name__}: `repository_name` is not in a valid format. " \
                           'Please check the docs for more info '\
                           'https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html' \
    end

    # Validate image identifiers:
    # https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_ImageIdentifier.html
    raise ArgumentError, "#{@__resource_name__}: `image_tag` must be maximum 300 characters long." if opts[:image_tag] && !opts[:image_tag].length.between?(1, 300)

    raise ArgumentError, "#{@__resource_name__}: `image_digest` must be a sha256 digest, e.g. 'sha256:aa..00'" if opts[:image_digest] && !/[a-zA-Z0-9\-_+.]+:[a-fA-F0-9]+/.match?(opts[:image_digest])

    query_params = {
      repository_name: opts[:repository_name],
      image_ids: [
        opts.select { |k, _v| k.to_s.start_with?('image') },
      ],
    }

    # Validate registry_id. (Optional. If not provided, AWS account ID will be used by the AWS API.)
    if opts.key?(:registry_id)
      raise ArgumentError, "#{@__resource_name__}: `registry_id` should be a string of 12 digits." unless /^[0-9]{12}$/.match?(opts[:registry_id])
      query_params[:registry_id] = opts[:registry_id]
    end

    catch_aws_errors do
      resp = @aws.ecr_client.describe_images(query_params)
      @image = resp.image_details.first.to_h
      create_resource_methods(@image)
    end
  end

  def exists?
    !@image.nil? && !@image.empty?
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
        @resp_scan = @aws.ecr_client.describe_image_scan_findings(query_params)
        @scan_findings += @resp_scan.image_scan_findings.findings
      end
      # Return if AWS returned an error.
      return if @resp_scan.nil?
      break unless @resp_scan.next_token
      query_params[:next_token] = @resp_scan[:next_token]
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
    return unless @image.key?(:image_scan_findings_summary)
    counts = image_scan_findings_summary.finding_severity_counts.item
    counts.transform_keys(&:downcase).transform_keys(&:to_sym)
  end

  def cve_ids
    vulnerabilities.map { |v| v[:name] }
  end

  def highest_vulnerability_severity
    vulnerabilities.map { |v| v[:CVSS2_SCORE] }.max.to_i
  end

  def tags
    image_tags
  end

  def resource_id
    return @display_name unless exists?
    "#{@image[:repository_name]}_#{@image[:image_digest]}"
  end

  def to_s
    "ECR Image #{@display_name}"
  end
end
