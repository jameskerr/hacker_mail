class HackerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.hacker_mailer.top_stories.subject
  #
  def top_stories(email, threshold)
    ids = Sample.score_above(threshold).between(1.day.ago, Time.now).story_ids
    subscriber = Subscriber.find_by email: email
    sent_ids = subscriber.stories.ids
    @stories = Story.where(id: ids).where.not(id: sent_ids).load
    @threshold = threshold

    if !@stories.empty?
      mail to: email, subject: "#{@stories.length} HN Stories"
      subscriber.stories << @stories
    end
  end

  def confirmation
    @subscriber = params[:subscriber]
    mail to: @subscriber.email, subject: "Hacker Mail Confirmation"
  end

  def update_link
    @subscriber = params[:subscriber]
    mail to: @subscriber.email, subject: "Hacker Mail Update Link"
  end
end
