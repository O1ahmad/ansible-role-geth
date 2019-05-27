title "Geth source installation default test suite"

describe user('test') do
  it { should exist }
end

describe group('test') do
  it { should exist }
end

describe file('/opt/geth/geth') do
  it { should exist }
  its('user') { should eq 'test' }
  its('group') { should eq 'test' }
end

describe command('/opt/geth/geth version') do
  its('exit_status') { should eq 0 }
end