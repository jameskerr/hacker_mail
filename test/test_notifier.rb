class TestNotifier
  attr_reader :messages

  def initialize
    @messages = []
  end

  def send(msg)
    @messages << msg
  end
end
