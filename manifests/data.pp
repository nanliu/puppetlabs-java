class java::data {

  case $::osfamily {
    'redhat': {
      $java_jre_package_name = 'jre'
      $java_jdk_package_name = 'jdk'
    }
    'debian': {
      $java_jre_package_name  = 'sun-java6-jre'
      $java_jdk_package_name  = 'sun-java6-jdk'
      $java_response_file     = '/var/local/sun-java6.preseed'
      $java_response_template = "${module_name}/sun-java6.preseed"
    }
  }

}
