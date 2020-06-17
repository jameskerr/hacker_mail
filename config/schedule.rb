# http://github.com/javan/whenever

set :output, "./log/cron.log"
set :environment, "production"

every 5.minutes do
  rake "sample"
end

every 1.day at: "7:03 am" do
  rake "email"
end
