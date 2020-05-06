require_relative 'aws_base_resource_mock'

class AwsEcrImageMock < AwsBaseResourceMock
  def multiple(n)
    # Create multiple ECR images
    mocks = []
    n.times do
      mocks << {
          registry_id: "477123926478",
          repository_name: "inspec-test",
          image_digest: "sha256:0a10bdef0c4824ed5ad1888961e077ff56e2e501d7f3ecf9e2c3fb2b5d538fcd",
          image_tags: %w[latest arbitrary_tag_1],
          image_size_in_bytes: 2108694,
          image_pushed_at: Time.parse(@aws.any_date.to_s),
          image_scan_status: {
              status: "COMPLETE",
              description: "The scan was completed successfully."
          },
          image_scan_findings_summary: {
              image_scan_completed_at: Time.parse(@aws.any_date.to_s),
              vulnerability_source_updated_at: Time.parse(@aws.any_date.to_s),
              finding_severity_counts: {
                  "HIGH" => 1,
                  "LOW" => 3
              }
          }
      }
    end
    mocks.freeze
  end
end
