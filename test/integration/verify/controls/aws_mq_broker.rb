# frozen_string_literal: true

broker_id = attribute(:broker_id, value: '', description: 'broker name.')
broker_arn = attribute(:broker_arn, value: '', description: 'broker arn.')

title 'Test a AWS MQ Broker.'
control 'aws_mq_broker-1.0' do
  impact 1.0
  title 'Ensure AWS MQ Broker has the correct properties.'

  describe aws_mq_broker(broker_id: broker_id) do
    it { should exist }
    its('broker_arn') { should include broker_arn }
    its('broker_name') { should include 'test_broker'  }
    its('broker_state') { should include "Running" }
    its('engine_type') { should include "ActiveMQ"  }
  end
end

