class windows_java::params (
  $url        = undef,
  $chocolatey = 'true'
){

  $java_url = $::architecture ? {
    /(x64)/ => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75261',
    default => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75259'
  }

  $java_package = $::architecture ?{
    /(x64)/ => 'Java 7 Update 17 (64-bit)',
    default => 'Java 7 Update 17'
  }

  $chocolatey_package = 'java.jdk'

  $package  = $chocolatey ?{
    /(true)/  => $chocolatey_package,
    default   => $java_package
  }
}
