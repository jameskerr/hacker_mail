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
end
