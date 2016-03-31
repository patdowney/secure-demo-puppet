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
  String $vhost = 'configui',
  Integer $port = 443,
  Array $upstream_hosts = [],
  String $upstream_proto = 'https'
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
