class SampleStories
  def self.run
    uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new uri
      res = http.request req
      ids = JSON.parse(res.body)


      ids.each do |id|
        uri = "https://hacker-news.firebaseio.com/v0/item/#{id}/.json"
        req = Net::HTTP::Get.new uri
        res = http.request req
        item = JSON.parse(res.body)
        score = item["score"]
        title = item["title"]

        if score > 500
          puts "#{score} --- #{title}"
        end
      end
    end
  end
end
