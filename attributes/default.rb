default['wkhtmltopdf']['version']     = '0.12.4'
default['wkhtmltopdf']['build_sha']   = '03c001d'
default['wkhtmltopdf']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf']['lib_dir']     = ''

case node['platform_family']
when 'mac_os_x', 'mac_os_x_server'
  default['wkhtmltopdf']['dependency_packages'] = []
  default['wkhtmltopdf']['platform'] = 'macosx-10.9.1-x86_64'
when 'windows'
  default['wkhtmltopdf']['dependency_packages'] = []
  if node['kernel']['machine'] == 'x86_64'
    default['wkhtmltopdf']['platform'] = 'win64'
  else
    default['wkhtmltopdf']['platform'] = 'win32'
  end
else
  default['wkhtmltopdf']['dependency_packages'] = value_for_platform_family(
    %w(debian) => %w(libfontconfig1 libssl0.9.8 libxext6 libxrender1),
    %w(fedora rhel) => %w(fontconfig libXext libXrender openssl-devel urw-fonts)
  )
  if node['kernel']['machine'] == 'x86_64'
    default['wkhtmltopdf']['platform'] = 'linux-generic-amd64'
  else
    default['wkhtmltopdf']['platform'] = 'linux-generic-i386'
  end
end

default['wkhtmltopdf']['archive']     = "wkhtmltox-#{node['wkhtmltopdf']['version']}_#{node['wkhtmltopdf']['platform']}.tar.xz"
default['wkhtmltopdf']['mirror_url']  = "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{node['wkhtmltopdf']['version']}/#{node['wkhtmltopdf']['archive']}"
