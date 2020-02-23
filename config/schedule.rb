# http://github.com/javan/whenever

set :output, "./log/cron.log"
set :environment, "development"

every 5.minutes do
  rake "stories:sample"
end

every 1.day at: "7:00 am" do
  rake "emails:send"
end
