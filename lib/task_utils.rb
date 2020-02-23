def log_task(name, &block)
  start = Time.now
  block.call
  sec = Time.now - start
  puts "ts=#{start} task=#{name} duration=#{sec.round(1)}sec"
end
