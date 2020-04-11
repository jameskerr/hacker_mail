class ConfirmSubscriber
  def self.run(subscriber, notifier = SlackNotifier.new)
    return false if subscriber.confirmed?
    if subscriber.update confirmed: true
      notifier.send("🥳 New subscriber: #{subscriber.email} (#{subscriber.threshold})")
      return true
    else
      return false
    end
  end
end
