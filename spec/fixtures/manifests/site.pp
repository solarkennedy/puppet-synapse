define initscript(
  $command,
  $manage_service = true,
  $user = undef,
  $group = undef,
  $service_ensure = 'running',
  $service_enable = true,
  $has_reload = true,
  $reload_command = undef,
  $launchd_name = undef,
  $description = '',
  $short_description = '',
  $init_style = undef,
  $source_default_file = false,
  $default_file_path = undef,
  $before_command = [],
  $ulimit = {}
) {}
