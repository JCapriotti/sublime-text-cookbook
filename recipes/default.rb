#
# Cookbook Name:: sublime-text
# Recipe:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

begin
  case node['platform_family']
  when "rhel", "fedora"
    include_recipe "sublime-text::platform_redhat"
  else
    include_recipe "sublime-text::platform_#{node[:platform]}"
  end

rescue Chef::Exceptions::RecipeNotFound => e
  log "!!!! This Cookbook does not support #{node[:platform]} :( !!!!"
  raise e
end

