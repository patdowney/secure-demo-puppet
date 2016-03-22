#if hiera('profiles', undef) != undef {
#  $profiles_array = hiera_array('profiles')
#  class { $profiles_array: }
#}

node default {
  class { "::role::${role}": }
}
