title "Geth package installation default test suite"

describe package('ethereum') do
  it { should be_installed }
end

describe command('geth version') do
  its('exit_status') { should eq 0 }
end