class SlackNotifier
  attr_reader :client

  def initialize
    @client = Slack::Web::Client.new
  end

  def send(msg)
    client.chat_postMessage(channel: "#server", text: msg)
  end
end
