class SampleStories
  def self.run
    uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
    now = Time.now
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new uri
      res = http.request req
      ids = JSON.parse(res.body)

      ids.take(30).map do |id|
        uri = "https://hacker-news.firebaseio.com/v0/item/#{id}/.json"
        req = Net::HTTP::Get.new uri
        res = http.request req
        JSON.parse(res.body)
      end.map do |item|
        return if !item
        title = item["title"]
        score = item["score"]
        id = item["id"]
        url = item["url"] || "https://news.ycombinator.com/item?id=#{id}"
        Story.upsert(id: id, title: title, url: url)
        Sample.create!(ts: now, score: score, story_id: id)
      end
    end
  end
end
