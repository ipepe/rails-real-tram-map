

unless defined?(Rails::Console) || File.split($0).include?('rake')
  Rails.application.db_safely do
    Rails.application.scheduler.every '9s' do
      puts "#{Time.now}@Refreshing tram data"
      Tram.refresh_data
    end
  end
end
