class HackerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.hacker_mailer.top_stories.subject
  #
  def top_stories
    @subscriber = params[:subscriber]
    @stories = params[:stories]
    if !@stories.empty?
      mail to: @subscriber.email, subject: "#{@stories.length} HN Stories"
      @subscriber.stories << @stories
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
