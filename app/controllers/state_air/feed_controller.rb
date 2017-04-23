class StateAir::FeedController < ApplicationController
  CITIES = {
    :beijing => [1, 'Beijing'],
    :chengdu => [2, 'Chengdu'],
    :guangzhou => [3, 'Guangzhou'],
    :shanghai => [4, 'Shanghai'],
    :shenyang => [5, 'Shenyang']
  }

  def latest
    city = params[:city]
    url = 'http://www.stateair.net/web/rss/1/%d.xml' % CITIES[city.to_sym][0]
    response = HTTParty.get(url)
    # response.body, response.code, response.message, response.headers.inspect

    @items = []
    Nokogiri::XML(response.body).css("rss channel item").each do |item|
      hash = Hash[ item.children.map{|c| [c.name.underscore.to_sym, c.text.strip]} ]
      hash[:city] = city
      hash[:reading_at] = DateTime.strptime "%s +08:00" % hash[:reading_date_time], "%m/%d/%Y %I:%M:%S %p %z"
      hash[:timestamp] = hash[:reading_at].to_i #.strftime("%Y%m%d%H%M%S%z")
      @items << hash
    end
  end

  private

  def city_url(city)
  end
end
