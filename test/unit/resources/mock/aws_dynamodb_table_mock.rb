require_relative 'aws_base_resource_mock'

class AwsDynamoDbTableMock < AwsBaseResourceMock

  def initialize
    super
    @mock_table = {table_name:              @aws.any_string,
                   table_status:           'ACTIVE',
                   creation_date_time:     Time.parse(@aws.any_date.to_s),
                   provisioned_throughput: {number_of_decreases_today: 0,
                                            write_capacity_units: 20,
                                            read_capacity_units: 20},
                   item_count:             @aws.any_int,
                   table_arn:              @aws.any_arn,
                   attribute_definitions:  [{attribute_name:@aws.any_string, attribute_type:'N'},
                                            {attribute_name: @aws.any_string, attribute_type:'S'},
                                            {attribute_name: @aws.any_string, attribute_type:'B'}],
                   key_schema:             [{attribute_name:@aws.any_string, :key_type =>'HASH'},
                                            {attribute_name:@aws.any_string, :key_type =>'RANGE'}],
                   sse_description: { status: 'ENABLED',
                                      sse_type: 'KMS',
                                      kms_master_key_arn: "arn:kms:us-west-2:243254392u3-32r324" },
                   billing_mode_summary:   {'billing_mode': 'PAY_PER_REQUEST'},
                   stream_specification:   {'stream_enabled': true,
                                            'stream_view_type': 'NEW_AND_OLD_IMAGES'},
                   replicas: [{'region_name': 'eu-west-2',
                               'replica_status': 'ACTIVE'}]
    }
  end

  def stub_data
    stub_data = []

    config = {:client => Aws::DynamoDB::Client,
              :method => :describe_table,
              :data => {table: @mock_table}
    }

    stub_data += [config]
  end

  def configuration
    @mock_table
  end
end


class AwsDynamoDbTableTTLMock < AwsBaseResourceMock

  def initialize
    super
    @mock_ttl = {'attribute_name': 'ttl',
                 'time_to_live_status': 'ENABLED'}
  end

  def stub_data
    stub_data = []

    config = {:client => Aws::DynamoDB::Client,
              :method => :describe_time_to_live,
              :data => {time_to_live_description: @mock_ttl}
    }

    stub_data += [config]
  end

  def configuration
    @mock_ttl
  end
end
