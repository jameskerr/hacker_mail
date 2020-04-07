require "test_helper"

class SentStoryTest < ActiveSupport::TestCase
  test "no one confirmed" do
    Subscriber.update_all confirmed: false

    SendEmails.run

    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test "one person confirmed" do
    Subscriber.update_all confirmed: false
    Subscriber.first.update! confirmed: true, threshold: 50
    Sample.first.update ts: Time.now, score: 51

    SendEmails.run

    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test "does not send twice" do
    Subscriber.update_all confirmed: false
    Subscriber.first.update! confirmed: true, threshold: 50
    Sample.first.update ts: Time.now, score: 51

    SendEmails.run
    SendEmails.run

    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test "does not send if below threshold" do
    Subscriber.update_all confirmed: false
    Subscriber.first.update! confirmed: true, threshold: 50
    Sample.first.update ts: Time.now, score: 49

    SendEmails.run

    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test "does not send if more than one day ago" do
    Subscriber.update_all confirmed: false
    Subscriber.first.update! confirmed: true, threshold: 50
    Sample.first.update ts: Time.now - 1.day, score: 51

    SendEmails.run

    assert_equal 0, ActionMailer::Base.deliveries.size
  end
end
