require "./lib/task_utils.rb"

desc "Sample the hacker news posts api"
task sample: :environment do |name|
  log_task(name) { SampleStories.run }
end

desc "Show the current stories above the threshold"
task show: :environment do
  query = <<-SQL
      SELECT DISTINCT stories.title, stories.url, samples.score
      FROM stories
      JOIN samples
      ON stories.id = samples.story_id
      LEFT JOIN samples samples2
      ON samples2.story_id = samples.story_id
      AND samples2.score > samples.score
      WHERE samples2.story_id IS NULL
      ORDER BY samples.score
    SQL

  results = Story.find_by_sql(query)

  results.each do |s|
    puts s.title
    puts s.url
    puts s.score
  end
end
