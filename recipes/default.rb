#
# Cookbook:: JenkinsServer
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package 'java-1.8.0-openjdk-devel'

execute 'Download_Repo_File' do
  command 'sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo|sudo tee /etc/yum.repos.d/jenkins.repo'
  creates '/etc/yum.repos.d/jenkins.repo'
end

execute 'Importing_Repo_File' do
  command 'sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

package 'jenkins' do
  version '2.121.2'
end

service 'jenkins' do
  action [:enable, :start]
end

firewall 'default' do
  log_level :high
  action :install
end

firewall_rule 'SSHPort' do
  port     22
  protocol :tcp
  command   :allow
end

firewall_rule 'JenkinsPort' do
  port     8080
  protocol :tcp
  command   :allow
end

output='#{Chef::JSONCompat.to_json_pretty(node.to_hash)}''
log output
