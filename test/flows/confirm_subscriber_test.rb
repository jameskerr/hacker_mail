require "test_helper"
require "test_notifier"

class ConfirmSubscriberTest < ActiveSupport::TestCase
  attr_reader :s, :n

  def setup
    @s = subscribers(:one)
    @n = TestNotifier.new
  end

  test "notify" do
    s.update! threshold: 300, confirmed: false
    assert_equal true, ConfirmSubscriber.run(s, n)
    assert_equal "🥳 New subscriber: one@gmail.com (300)", n.messages.first
  end

  test "if confirmed returns false" do
    s.update! confirmed: true
    assert_equal false, ConfirmSubscriber.run(s, n)
    assert_equal [], n.messages
  end

  test "confirms subscriber" do
    s.update! confirmed: false
    ConfirmSubscriber.run(s, n)
    assert_equal true, s.confirmed
  end
end
