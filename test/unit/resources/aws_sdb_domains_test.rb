require 'helper'
require 'aws_sdb_domains'
require 'aws-sdk-core'

class AWSSDBDomainsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSDBDomains.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSSDBDomains.new('rubbish') }
  end
end

class AWSSDBDomainsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_domains
    mock_data = {}
    mock_data[:domain_names] = ['DomainName']
    data[:data] = [mock_data]
    data[:client] = Aws::SimpleDB::Client
    @resp = AWSSDBDomains.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_name_exists
    assert @resp.exist?
  end

  def test_domain_names
    assert_equal(@resp.domain_names, ['DomainName'])
  end
end