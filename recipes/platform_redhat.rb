

download_url = node['sublime-text']['download_uri']
install_path = node['sublime-text']['install_path']
version = node['sublime-text']['version']['generation']

ark 'subl' do
  url download_url
  path install_path
  version "#{version}"
  action :install
end

exec_path = "#{install_path}/subl-#{version}/sublime_text"
icon_path = "#{install_path}/subl-#{version}/Icon/128x128/sublime-text.png"

if node['sublime-text']['gnome_icon']
  template "/usr/share/applications/sublime-text-3.desktop" do
    source "sublime-text-3.desktop.erb"
    variables({
      :sublime_path => exec_path,
      :sublime_icon => icon_path
    })
  end
end