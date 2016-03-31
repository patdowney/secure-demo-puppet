# Class: base::diagnostics
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
class base::diagnostics() {
  package {
    'strace':
      ensure => latest;
    'ltrace':
      ensure => latest;
    'lsof':
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
