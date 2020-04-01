require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  test "generates a uid on create" do
    s = Subscriber.create(email: "james@kerr.com", threshold: 100)
    assert_not_empty s.key
  end
end
