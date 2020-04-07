# Preview all emails at http://localhost:3000/rails/mailers/hacker_mailer
class HackerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/hacker_mailer/top_stories
  def top_stories
    s = Subscriber.find_by(email: "jkerr838@gmail.com") ||
        Subscriber.create(email: "jkerr838@gmail.com", threshold: 300)
    HackerMailer.with(subscriber: s, stories: Story.take(5)).top_stories
  end

  def confirmation
    s = Subscriber.new(email: "jkerr838@gmail.com", threshold: 300)
    s.generate_key

    HackerMailer.with(subscriber: s).confirmation
  end

  def update_link
    s = Subscriber.new(email: "jkerr838@gmail.com", threshold: 300)
    s.generate_key

    HackerMailer.with(subscriber: s).update_link
  end
end
