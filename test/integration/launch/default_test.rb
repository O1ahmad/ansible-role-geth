title "Geth service management setup default test suite"

describe service('geth') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
