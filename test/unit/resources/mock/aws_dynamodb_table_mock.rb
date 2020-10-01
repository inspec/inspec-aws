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
                                      kms_master_key_arn: "arn:kms:us-west-2:243254392u3-32r324" }
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