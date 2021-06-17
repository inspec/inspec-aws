require 'helper'
require 'aws_ram_resource_shares'
require 'aws-sdk-core'

class AWSRAMResourceSharesConstructorTest < Minitest::Test

    def test_empty_params_ok
        AWSRAMResourceShares.new(resource_owner: 'test1', client_args: { stub_responses: true })
    end

    def test_rejects_other_args
        assert_raises(ArgumentError) { AWSRAMResourceShares.new('rubbish') }
    end

    def test_metric_filters_non_existing_for_empty_response
        refute AWSRAMResourceShares.new(resource_owner: 'SELF', client_args: { stub_responses: true }).exist?
    end
end

class AWSRAMResourceSharesHappyPathTest < Minitest::Test

    def setup
        data = {}
        data[:method] = :list_resources
        mock_data = {}
        mock_data[:arn] = 'test1'
        mock_data[:type] = 'test1'
        mock_data[:resource_share_arn] = 'test1'
        mock_data[:resource_group_arn] = 'test1'
        mock_data[:status] = 'test1'
        mock_data[:status_message] = 'test1'
        mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        mock_data[:last_updated_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
        data[:data] = { :resources => [mock_data] }
        data[:client] = Aws::RAM::Client
        @resources = AWSRAMResourceShares.new(resource_owner: 'test1', client_args: { stub_responses: true }, stub_data: [data])
    end

    def test_resources_exists
        assert @resources.exist?
    end

    def test_arns
        assert_equal(@resources.arns, ['test1'])
    end

    def test_types
        assert_equal(@resources.types, ['test1'])
    end

    def test_resource_share_arns
        assert_equal(@resources.resource_share_arns, ['test1'])
    end

    def test_resource_group_arns
        assert_equal(@resources.resource_group_arns, ['test1'])
    end

    def test_statuses
        assert_equal(@resources.statuses, ['test1'])
    end

    def test_status_messages
        assert_equal(@resources.status_messages, ['test1'])
    end

    def test_creation_times
        assert_equal(@resources.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end

    def test_last_updated_times
        assert_equal(@resources.last_updated_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
    end
end