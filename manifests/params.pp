class windows_java::params {
  $url     = $java_url
  $package = $java_package

  $java_url = $::architecture ? {
    /(x64)/ => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75261',
    default => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75259',
  }

  $java_package = $::architecture ?{
    /(x64)/ => 'Java 7 Update 17 (64-bit)',
    default => 'Java 7 Update 17',
  }

}
