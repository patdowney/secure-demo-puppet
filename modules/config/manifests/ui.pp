# Class: config::ui
# ===========================
#
# Parameters
# ----------
#
# Variables
# --------
#
# Examples
# --------
#
# Authors
# -------
#
# Copyright
# ---------
#
class config::ui(
  $vhost = 'configui', # String
  $port = 443, # Integer
  $upstream_hosts = [], # Array
  $upstream_proto = 'https' # String
) {

  include ::nginx

  nginx::resource::upstream { "upstream.${vhost}":
    members => $upstream_hosts,
  }

  nginx::resource::vhost { $vhost:
    listen_port => $port,
    proxy       => "${upstream_proto}://upstream.${vhost}",
  }
}
