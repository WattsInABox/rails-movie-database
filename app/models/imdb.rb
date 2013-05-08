module IMDB
  class Search
    def self.by_id(id)
      id = "tt#{id}"  unless id =~ /^tt/
      id_url = "http://imdbapi.org/?id=#{URI::escape id}&type=json&plot=simple&episode=0&lang=en-US&aka=simple&release=simple&business=0&tech=0"
      get_and_parse(id_url)
    end

    def self.by_title(title, options={})
      options[:limit] ||= 1
      
      title_url = "http://imdbapi.org/?title=#{URI::escape title}&type=json&plot=simple&episode=0&limit=#{options[:limit]}&yg=0&mt=none&lang=en-US&offset=&aka=simple&release=simple&business=0&tech=0"
      get_and_parse(title_url)
    end

    protected 

    def self.get_and_parse(url)
      JSON(RestClient.get(url))
    end
  end
end