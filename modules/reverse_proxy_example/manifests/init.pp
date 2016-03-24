class reverse_proxy_example(
  String $vhost = "api.example.com",
  Integer $port = 80,
  Array $members = []
) {

  nginx::resource::upstream { "upstream.${vhost}":
    members => $members,
  }

  nginx::resource::vhost { $vhost:
    listen_port => $port,
    proxy => "http://upstream.${vhost}",
  }
}
