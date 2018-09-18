class google_fluentd::install(
  $conf_files = []){

  exec {'get_script':
    command => 'curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh',
    cwd => '/root/'.
  }
  exec {'install_google_fluentd':
    command => 'bash install-logging-agent.sh',
    cwd => '/root/'.
  }

  $files.each |String $file| {
    $name = basename($file)
    $path = "/etc/google-fluentd/config.d/${name}"
    file {$name:
      path => $path,
      source => $file,
      owner => 'root',
      group => 'root',
      mode => '0644',
    }
  }

  if $files {
    exec {'restart_google_fluentd':
      command => 'systemctl restart google-fluentd',
    }
  }
}
