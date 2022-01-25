require 'helper'
require 'aws_waf_web_acls'
require 'aws-sdk-core'

class AWSWAFWebACLSConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSWAFWebACLS.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSWAFWebACLS.new(test: 'rubbish') }
  end
end

class AWSWAFWebACLSHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_web_acls
    mock_data = {}
    mock_data[:web_acls] = [{ web_acl_id: 'web_acl_id', name: 'name' }]
    data[:data] = mock_data
    data[:client] = Aws::WAF::Client
    @resp = AWSWAFWebACLS.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_xss_match_set_exists
    assert @resp.exist?
  end

  def test_xss_match_set_ids
    assert_equal(@resp.web_acl_ids, ['web_acl_id'])
  end
end