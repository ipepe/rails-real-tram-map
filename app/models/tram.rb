class Tram < ActiveRecord::Base

  API_URL="https://api.um.warszawa.pl/api/action/wsstore_get/?id=c7238cfe-8b1f-4c38-bb4a-de386db7e776&apikey="

  def self.refresh_data
    uri = URI(API_URL+ENV['WAW_API_KEY'])
    JSON.parse(Net::HTTP.get(uri))['result'].each do |tram_data|
      tram = Tram.find_or_create_by(
          line: tram_data['FirstLine'].gsub(/\s+/, "").to_i,
          brigade: tram_data['Brigade'].gsub(/\s+/, "").to_i
      )
      tram.latitude = tram_data['Lat']
      tram.longitude = tram_data['Lon']
      tram.save
    end
  end

  scope :currently_running, -> do
    where('updated_at > :time_limit', time_limit: Time.now-3.minutes )
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
        brigade: self.brigade
    }
  end

  def should_animate
    #sprawdzic roznice miedzy previous lat/lon do current
    true
  end

  def latitude=(value)
    super
    self.previous_latitude=value
  end

  def longitude=(value)
    super
    self.previous_longitude=value
  end
end
