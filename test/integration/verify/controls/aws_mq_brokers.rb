broker_arn = input(:broker_arn, value: '', description: '')

title 'Test AWS MQ Broker in bulk.'

control 'aws_mq_brokers-1.0' do
  title 'Ensure AWS MQ Brokers has the correct properties.'
  
  describe aws_mq_brokers do
    it { should exist }
    its('broker_arns') { should include broker_arn }
    its('broker_names') { should include 'test_broker'  }
    its('broker_states') { should include 'RUNNING' }
    its('engine_types') { should include 'ActiveMQ'  }
  end
end
