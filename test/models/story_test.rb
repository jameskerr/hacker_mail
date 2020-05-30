require "test_helper"

class StoryTest < ActiveSupport::TestCase
  test "destroying a story with a sent_story entry" do
    sub = subscribers(:one)
    story = stories(:one)
    sub.stories << story

    story.destroy!

    assert story.destroyed?
  end

  test "destroying a story with a sample entry" do
    sample = samples(:one)
    story = stories(:one)
    story.samples << sample

    story.destroy!

    assert story.destroyed?
  end

  test "stories with max scores" do
    stories(:one).samples << Sample.new(score: 1000)
    stories(:one).samples << Sample.new(score: 5000)

    story = Story
      .select(:id, :title, :score)
      .join_max_score
      .order("score DESC")
      .first

    assert_equal "Story One", story.title
    assert_equal 5000, story.score
  end

  test "next up for subscriber only above threshold" do
    subscriber = subscribers :one
    story = stories :one

    subscriber.update! threshold: 100
    assert_equal 0, Story.next_up_for(subscriber).count(:id)

    story.samples << Sample.new(score: 99)
    assert_equal 0, Story.next_up_for(subscriber).count(:id)

    story.samples << Sample.new(score: 100)
    assert_equal 1, Story.next_up_for(subscriber).count(:id)

    story.samples << Sample.new(score: 200)
    assert_equal 1, Story.next_up_for(subscriber).count(:id)
    assert_equal 200, Story.next_up_for(subscriber).first.score

    subscriber.stories << story

    assert_equal 0, Story.next_up_for(subscriber).count(:id)
  end

  test "next up for subscriber sorts by score" do
    subscriber = subscribers :one
    story1 = stories :one
    story2 = stories :two
    subscriber.update! threshold: 100

    story1.samples.clear
    story2.samples.clear
    story1.samples << Sample.new(score: 200)
    story2.samples << Sample.new(score: 199)

    assert_equal [200, 199], Story.next_up_for(subscriber).map(&:score)
  end
end
