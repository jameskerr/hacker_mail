require "./lib/task_utils.rb"

namespace :emails do
  desc "TODO"
  task send: :environment do |name|
    log_task(name) { SendEmails.run }
  end
end
