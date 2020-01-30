namespace :stories do
  desc "Sample the hacker news posts api"
  task sample: :environment do
    SampleStories.run
  end
end
