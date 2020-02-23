# Preview all emails at http://localhost:3000/rails/mailers/hacker_mailer
class HackerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/hacker_mailer/top_stories
  def top_stories
    HackerMailer.top_stories("jkerr838@gmail.com", 300)
  end

end
