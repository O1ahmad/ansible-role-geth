title "Geth package installation integration tests"

describe user('test') do
  it { should exist }
end

describe group('test') do
  it { should exist }
end

describe package('ethereum') do
  it { should be_installed }
end

describe command('geth version') do
  its('exit_status') { should eq 0 }
end
