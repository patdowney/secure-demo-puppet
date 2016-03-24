class profile::java() {
  class { 'oracle_java':
    add_alternative => true
  }
}
