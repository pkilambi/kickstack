# Class: kickstack
#
# The kickstack class serves as a central place to
# collect global configuration that needs to be globally available
# to your entire openstack infrastructure
#
class kickstack (
  $package_ensure      = hiera('package_ensure', 'present'),
  $name_resolution     = hiera('name_resolution', 'hosts'),
  $verbose             = hiera('verbose', false),
  $debug               = hiera('debug', false),

  # global auth information
  $auth_region         = hiera('auth_region', 'RegionOne'),
  $auth_service_tenant = hiera('service_tenant', 'services'),

  # I am not sure if the type stuff should be here, in most cases,
  # it simply maps to a single class.
  # but is it more convenient to be here?
  # allows users to globally select all of the backends that need to be configured
  $db_type             = hiera('db_type', $::kickstack::params::db_type),
  $rpc_type            = hiera('rpc_type', $::kickstack::params::rpc_type),
  $cinder_backend      = hiera('cinder_backend', 'iscsi'),
  $glance_backend      = hiera('glance_backend', 'file'),
  $nova_compute_type   = hiera('compute_type', 'libvirt'),
  # supports quantum and nova network
  $network_type        = hiera('network_type', 'quantum'),
  # what is the difference between these two?
  $quantum_network_type = $kickstack::params::quantum_network_type,
  $quantum_plugin = $kickstack::params::quantum_plugin,


  $management_nic      = hiera('management_nic', 'eth2'),
  # TODO - not sure if I need these
  #$keystone_public_suffix = $kickstack::params::keystone_public_suffix,
  #$keystone_admin_suffix = $kickstack::params::keystone_admin_suffix,
) inherits kickstack::params {

  # should these be here? (probably)
  include openstack::repo
  if $nameresolution == 'hosts' {
    include kickstack::nameresolution
  }

}
