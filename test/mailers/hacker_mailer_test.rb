require 'test_helper'

class HackerMailerTest < ActionMailer::TestCase
  test "top_stories" do
    mail = HackerMailer.top_stories
    assert_equal "Top stories", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
