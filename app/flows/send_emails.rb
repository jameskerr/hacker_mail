class SendEmails
  def self.run
    new().run
  end

  def run
    Subscriber.where(confirmed: true).each do |s|
      HackerMailer
        .with(subscriber: s, stories: stories_for(s))
        .top_stories
        .deliver_now
    end
  end

  private

  def stories_for(subscriber)
    Story
      .where(id: Sample
               .score_above(subscriber.threshold)
               .between(1.day.ago, Time.now)
               .story_ids)
      .where
      .not(id: subscriber.stories.ids)
      .load
  end
end
