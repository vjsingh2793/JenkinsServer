# # encoding: utf-8

# Inspec test for recipe JenkinsServer::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('java-1.8.0-openjdk-devel') do
  it {should be_installed}
end

describe file('/etc/yum.repos.d/jenkins.repo') do
  it {should exist}
end

describe port(22) do
  it {should be_listening}
end

describe port(8080) do
  it {should be_listening}
end
