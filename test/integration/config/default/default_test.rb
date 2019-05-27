title "Geth TOML configuration default test suite"

describe file('/etc/geth/config.toml') do
  it { should exist }
  its('content') { should match("[Eth]") }
  its('content') { should match("[Node]") }
  its('content') { should match('SyncMode = "fast"') }
  its('content') { should match('DataDir = "/var/geth"') }
end