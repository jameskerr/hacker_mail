require "./lib/task_utils.rb"

desc "TODO"
task email: :environment do |name|
  log_task(name) { SendEmails.run }
end
