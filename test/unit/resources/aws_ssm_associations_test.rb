require 'helper'
require 'aws_ssm_associations'
require 'aws-sdk-ssm'

class AwsSsmAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSsmAssociations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSsmAssociations.new('rubbish') }
  end

  def test_ssm_associations_non_existing_for_empty_response
    refute AwsSsmAssociations.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSsmAssociationsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_associations
    mock_ssm_association = {}
    mock_ssm_association[:association_id] = "association-id-14325423"
    mock_ssm_association[:association_name] = "association-name-14325423"
    mock_ssm_association[:association_version] = "1"
    mock_ssm_association[:document_version] = "1"
    mock_ssm_association[:instance_id] = "instance-id-532542"
    mock_ssm_association[:last_execution_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_association[:name] = "document-name"
    mock_ssm_association[:overview] = { status: "Success",
                                        detailed_status: "Success",
                                        association_status_aggregated_count: {} }
    mock_ssm_association[:schedule_expression] = ""
    mock_ssm_association[:targets] = [{ key: "instanceids",
                                        values: ["i-52543f43ew234"] }]
    data[:data] = { associations: [mock_ssm_association] }
    data[:client] = Aws::SSM::Client
    @ssm_association = AwsSsmAssociations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_association_exists
    assert @ssm_association.exists?
  end

  def test_ssm_association_name
    assert_equal(@ssm_association.names, ["document-name"])
  end

  def test_ssm_association_id
    assert_equal(@ssm_association.association_ids, ["association-id-14325423"])
  end

  def test_ssm_association_version
    assert_equal(@ssm_association.association_versions, ["1"])
  end

  def test_ssm_association_last_execution_date
    assert_equal(@ssm_association.last_execution_dates, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end
end