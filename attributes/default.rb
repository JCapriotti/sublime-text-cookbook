#
# Cookbook Name:: sublime-text
# Attributes:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

default['sublime-text']['version']['generation'] = 3
default['sublime-text']['version']['id'] = case node['sublime-text']['version']['generation']
                                           when 2
                                             "2.0.2"
                                           when 3
                                             "Build 3065"
                                           end 

default['sublime-text']['platform']['release'] = 'trusty'
default['sublime-text']['platform']['architecture'] = 'amd64'

default['sublime-text']['repository']['uri'] = "http://ppa.launchpad.net/webupd8team/sublime-text-#{node['sublime-text']['version']['generation']}/ubuntu"
default['sublime-text']['repository']['keyserver'] = 'keyserver.ubuntu.com'
default['sublime-text']['repository']['key'] = 'EEA14886'

default['sublime-text']['install_path'] = '/usr/local'
default['sublime-text']['download_uri'] = ''
default['sublime-text']['gnome_icon'] = true

build_id = node['sublime-text']['version']['id'].gsub('Build ', '')
if node['sublime-text']['download_uri'] == ''
  case node['platform_family']
  when 'fedora', 'rhel'
    if node['sublime-text']['version']['generation'] == 2 and node['sublime-text']['platform']['architecture'] == 'amd64'
      default['sublime-text']['download_uri'] = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20#{build_id}%20x64.tar.bz2"
    elsif node['sublime-text']['version']['generation'] == 2
      default['sublime-text']['download_uri'] = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20#{build_id}.tar.bz2"
    elsif node['sublime-text']['version']['generation'] == 3 and node['sublime-text']['platform']['architecture'] == 'amd64'
      default['sublime-text']['download_uri'] = "http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_#{build_id}_x64.tar.bz2"
    elsif node['sublime-text']['version']['generation'] == 3
      default['sublime-text']['download_uri'] = "http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_#{build_id}_x32.tar.bz2"
    end
  when 'mac_os_x'
    default['sublime-text']['download_uri'] = "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%20#{build_id}.dmg"
  end
end

