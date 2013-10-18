# === Class: windows_java::disable
#
# This class removes the installed components.

class windows_java::disable (
  $package   = $::windows_java::params::package,
) inherits windows_java::params {

  package { $package:
    ensure  => absent,
  }

  windows_path { $java_path:
    ensure  => absent,
  }

  file { "${::temp}/${package}.exe":
    ensure  => absent,
  }

}
