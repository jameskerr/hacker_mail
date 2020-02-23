class ApplicationMailer < ActionMailer::Base
  default from: "HackerMail <mail@hn-alerts.com>"
  layout "mailer"
end
