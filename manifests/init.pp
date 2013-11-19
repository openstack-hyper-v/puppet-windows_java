# === Class: windows_java
#
# This module installs Java on Windows systems. It also adds an entry to the
# PATH environment variable.
#
# === Parameters
#
# [*url*]
#   HTTP url where the installer is available. It defaults to main site.
# [*package*]
#   Package name in the system.
# [*file_path*]
#   This parameter is used to specify a local path for the installer. If it is
#   set, the remote download from $url is not performed. It defaults to false.
#
# === Examples
#
# class { 'windows_java': }
#
# class { 'windows_java':
#   $url     => 'http://192.168.1.1/files/java.exe',
#   $package => 'Java 7 Update 17(64-Bit)',
# }
#
# === Authors
# 
#
class windows_java (
  $url       = $::windows_java::params::url,
  $package   = $::windows_java::params::package,
  $file_path = false
) inherits windows_java::params {

  if $chocolatey {
    Package { provider => chocolatey }
  } else {

    Package { 
      source          => $java_installer_path,
      install_options => ['/s', '/v/qn','ADDLOCAL=jrecore REBOOT=Suppress JAVAUPDATE=0'],
      provider => windows,
    }

    if $file_path {
      $java_installer_path = $file_path
    } else {
      $java_installer_path = "${::temp}\\${package}.exe"
      windows_common::remote_file{'Java':
        source      => $url,
        destination => $java_installer_path,
        before      => Package[$package],
      }
    }
  }
  package { $package:
    ensure          => installed,
  }

  if $::architecture == 'x64' {
    $java_path = 'C:\Program Files (x86)\Java\jre7\bin'
  } else {
    $java_path = 'C:\Program Files\Java\jre7\bin'
  }
 
  windows_path { $java_path:
    ensure  => present,
    require => Package[$package],
  }
}
