# Class: java
#
# This module manages the Java runtime package
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class java(
  $distribution      = hiera('java_distribution'),
  $version           = hiera('java_version', 'installed'),
  $response_file     = hiera('java_response_file', undef),
  $response_template = hiera('java_response_template', undef)
) {

  validate_re($distribution, '^jdk$|^jre$|^java.*$')
  validate_re($version, 'installed|^[._0-9a-zA-Z:-]+$')

  case $distribution {
    'jre', 'jdk': {
      $package_name = hiera("java_${distribution}_package_name")
    }
    default: {
      $package_name = $distribution
    }
  }

  validate_re($package_name, '^[._0-9a-zA-Z:-]+$')

  package { 'java':
    ensure       => $version,
    name         => $package_name,
    responsefile => $response_file,
  }

  case $::osfamily {
    'debian': {
      file { $response_file:
        content => template($response_template),
        before  => Package['java'],
      }
    }
  }

}
