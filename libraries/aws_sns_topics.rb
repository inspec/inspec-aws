# frozen_string_literal: true

require 'aws_backend'

class AwsSnsTopics < AwsResourceBase
  name 'aws_sns_topics'
  desc 'Verifies settings for SNS Topics in bulk'
  example "
    describe aws_sns_topics do
      its('topic_arns') { should include 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-auzoitotenajpdiftuiorkmrf' }
    end
  "

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters([])
  end

  # FilterTable setup
  filter_table_config = FilterTable.create
  filter_table_config.add(:topic_arns, field: :topic_arn)
  filter_table_config.connect(self, :fetch_data)

  def fetch_data
    topic_rows = []
    pagination_options = nil
    loop do
      catch_aws_errors do
        @api_response = @aws.sns_client.list_topics(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.topics.map do |topic|
        topic_rows += [{ topic_arn: topic.topic_arn }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = topic_rows
  end
end
