class google_fluentd(
  $conf_files = []){
  class { 'google_fluentd::install':
    conf_files => $conf_files,
  }
}
