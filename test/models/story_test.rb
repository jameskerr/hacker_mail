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

    subquery = <<-SQL
      SELECT story_id, score, ROW_NUMBER() OVER (PARTITION BY story_id ORDER BY score DESC) as row
      FROM samples
    SQL

    query = <<-SQL
      SELECT title, score
      FROM stories s
      JOIN (#{subquery}) scores
      ON s.id = scores.story_id AND row = 1
      ORDER BY score DESC
    SQL

    results = Story.find_by_sql(query).pluck(:title, :score)

    assert_equal results, [["Story One", 5000], ["Story Two", 252]]
  end
end
