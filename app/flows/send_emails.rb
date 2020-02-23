class SendEmails
  def self.run
    new().run
  end

  def run
    Subscriber.all.each do |subscriber|
      HackerMailer.top_stories(subscriber.email, subscriber.threshold).deliver_now
    end
  end
end
