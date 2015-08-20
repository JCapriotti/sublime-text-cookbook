#
# Cookbook Name:: sublime-text
# Recipe:: platform_mac_os_x
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

application_title = node['sublime-text']['version']['generation'] == 2 ? "Sublime Text 2" : "Sublime Text"
download_url = node['sublime-text']['download_uri']


ruby_block "dispatcher" do
  block do
    # Dummy Block
  end
  not_if { ::File.exists? "/Applications/#{application_title}.app" }
  notifies :create, "remote_file[download_sublime_dmg]", :immediately
  notifies :run, "execute[mount_sublime_dmg]", :immediately
  notifies :run, "execute[install_sublime_app]", :immediately
end

remote_file "download_sublime_dmg" do
  path "#{Chef::Config[:file_cache_path]}/Sublime_Text_#{node['sublime-text']['version']['id'].gsub(" ", "_")}.dmg"
  source download_url
  action :nothing
end

execute "mount_sublime_dmg" do
  command "hdiutil attach #{Chef::Config[:file_cache_path]}/Sublime_Text_#{node['sublime-text']['version']['id'].gsub(" ", "_")}.dmg"
  action :nothing
end

execute "install_sublime_app" do
  command "cp -r '/Volumes/#{application_title}/#{application_title}.app' /Applications/"
  action :nothing
  notifies :run, "execute[unmount_sublime_dmg]", :immediately
end

execute "unmount_sublime_dmg" do
  command "hdiutil detach '/Volumes/#{application_title}'"
  action :nothing
  only_if { ::File.exists? "/Volumes/#{application_title}" }
end

link "enable_command_line_executable" do
  target_file "/usr/local/bin/subl"
  to "/Applications/#{application_title}.app/Contents/SharedSupport/bin/subl"
end


