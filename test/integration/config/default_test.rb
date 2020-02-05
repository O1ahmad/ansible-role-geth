title "Geth configuration integration tests"

describe file('/etc/geth/config.toml') do
  it { should exist }
  its('content') { should match("[Eth]") }
  its('content') { should match("[Node]") }
  its('content') { should match('SyncMode = "full"') }
  its('content') { should match('DataDir = "/var/test"') }
end
