class SampleStories
  def self.run
    uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new uri
      res = http.request req
      ids = JSON.parse(res.body)

      ids.take(30).map do |id|
        uri = "https://hacker-news.firebaseio.com/v0/item/#{id}/.json"
        req = Net::HTTP::Get.new uri
        res = http.request req
        item = JSON.parse(res.body)
        title = item["title"]
        score = item["score"]
        url = item["url"] || ""
        id = item["id"]
        puts "#{title} - #{score}"
        {title: title, link: url, remote_id: id}
      end.map do |opts|
        Story.upsert(opts)
      end
      puts("Updated homepage stories")
    end
  end
end
