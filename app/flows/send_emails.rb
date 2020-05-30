class SendEmails
  def self.run
    new().to(Subscriber.where(confirmed: true))
  end

  def to(subscribers)
    subscribers.each do |s|
      HackerMailer
        .with(subscriber: s, stories: Story.next_up_for(s).load)
        .top_stories
        .deliver_now
    end
  end
end
