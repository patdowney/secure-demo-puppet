class base::diagnostics() {
  package {
    'strace':
      ensure => latest;
    'ltrace':
      ensure => latest;
    'lsof':
      ensure => latest;
    'linux-tools':
      ensure => latest;
    'iotop':
      ensure => latest;
    'ngrep':
      ensure => latest;
    'tcpdump':
      ensure => latest;
    'iftop':
      ensure => latest;
  }
}
