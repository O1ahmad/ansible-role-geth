title "Geth archive installation integration tests"

describe user('test') do
  it { should exist }
end

describe group('test') do
  it { should exist }
end

describe file('/opt/geth/geth') do
  it { should exist }
  its('owner') { should eq 'test' }
  its('group') { should eq 'test' }
  its('mode') { should cmp '0775' }
end

describe command('/opt/geth/geth version') do
  its('exit_status') { should eq 0 }
end
