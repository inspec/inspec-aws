# frozen_string_literal: true

require 'aws_backend'

class AwsSecurityHubFinding < AwsResourceBase
  name "aws_securityhub_finding"
  desc 'Verifies settings for an AWS SecurityHub Finding'
  example "
  describe aws_securityhub_finding(filters: {title: 'finding title') do
    it { should exist }
  end
  "
  
  def initialize(opts = {})
    super(opts)
    validate_parameters(required: [:filters])
    @filters = {filters: opts[:filters]}
    
    # Ensure the response will have a single finding.
    @filters[:max_results] = 1
    
    catch_aws_errors do
      begin
        resp = @aws.securityhub_client.get_findings **@filters
        @finding = resp.findings.first.to_h
        if @finding.empty?
          raise Aws::SecurityHub::Errors::FindingNotFound.new(resp, "#{@__resource_name__} not found.")
        end
      rescue Aws::SecurityHub::Errors::FindingNotFound
        return
      end
      create_resource_methods(@finding)
    end
  end

  def exists?
    !@finding.nil? && !@finding.empty?
  end

  def id
    @finding[:id]
  end

  def title
    @finding[:title]
  end

  def severity
    @finding[:severity][:label]
  end

  def resource_ids
    @finding[:resources].map {|r| r[:id]}
  end

  def compliance
    @finding[:compliance][:status]
  end

  def compliant?
    @finding[:compliance][:status] == "PASSED"
  end

  def workflow_status
    @finding[:workflow][:status]
  end

  def to_s
    if exists?
      # This version seems too long
      # "SecurityHub Finding '#{title}' of '#{id}'"
      "SecurityHub Finding '#{title}'"
    else
      "SecurityHub Finding '#{@filters[:filters][:title][0][:value]}' of '#{@filters[:filters][:resource_details_other][0][:value]}'"
    end
  end
end
