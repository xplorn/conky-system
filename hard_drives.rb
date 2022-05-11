require 'yaml'
secrets = YAML.load_file(ENV['HOME']+'/conky/secrets.yml')
active_device = secrets['hard_drives']['activity_for']

diskio = "${color}#{active_device}${goto 110}${diskio_write #{active_device}}${goto 180}${diskio_read #{active_device}}"

free_used_title = "$color0${voffset -5}${goto 85}Free${goto 210}Used${goto 350}Size"

partitions = []
secrets['hard_drives']['partitions'].each do |partition_name, partition|
  conky_partition = "${color0}#{partition_name}$color${goto 75}${fs_free #{partition}}${goto 150}$color2${voffset -5}${fs_bar 16,170 #{partition}}${goto 160}${voffset 5}$color0${fs_used #{partition}}${goto 345}${fs_size #{partition}}"
  partitions << conky_partition + "\n"
end

puts diskio

puts free_used_title

#puts '${font Liberation Mono:bold:size=9}' + partitions.inject(:+)
puts partitions.inject(:+)
