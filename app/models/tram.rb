class Tram < ActiveRecord::Base
  API_URL="https://api.um.warszawa.pl/api/action/wsstore_get/?id=c7238cfe-8b1f-4c38-bb4a-de386db7e776&apikey="

  reverse_geocoded_by :latitude, :longitude

  def self.refresh_data
    uri = URI(API_URL+ENV['WAW_API_KEY'])
    JSON.parse(Net::HTTP.get(uri))['result'].each do |tram_data|
      tram = Tram.find_or_create_by(
          line: tram_data['FirstLine'].gsub(/\s+/, "").to_i.to_s,
          brigade: tram_data['Brigade'].gsub(/\s+/, "").to_i.to_s
      )
      tram.latitude = tram_data['Lat']
      tram.longitude = tram_data['Lon']
      tram.save
    end
  end

  scope :currently_running, -> (latitude: 52.23, logitude: 21.01, radius: 20, limit: 100) do
    where('updated_at > :time_limit', time_limit: Time.now-3.minutes ).
        near([latitude, logitude], radius).limit(limit)
  end

  def serialized_hash
    {
        id: self.id,
        latitude: self.latitude,
        longitude: self.longitude,
        previous_latitude: self.previous_latitude,
        previous_longitude: self.previous_longitude,
        should_animate: self.should_animate,
        line: self.line,
        brigade: self.brigade,
        popup_marker_html: self.popup_marker_html
    }
  end

  def popup_marker_html
    """#{I18n.t('trams.line')}: #{self.line}<br/>#{I18n.t('trams.brigade')}: #{self.brigade}<br/>""" +
        """<a href=\"http://m.ztm.waw.pl/rozklad_nowy.php?c=182&l=1&q=#{self.line}\">#{I18n.t('trams.timeline')} (http://www.ztm.waw.pl)</a>"""
  end

  def should_animate
    #sprawdzic roznice miedzy previous lat/lon do current
    Geocoder::Calculations.distance_between(
        [self.previous_latitude, self.previous_longitude],
        [self.latitude, self.longitude]
    ) < 1
  end

  def latitude=(value)
    self.previous_latitude= self.latitude if self.latitude != self.previous_latitude
    super
  end

  def longitude=(value)
    self.previous_longitude=self.longitude if self.longitude != self.previous_longitude
    super
  end
end
