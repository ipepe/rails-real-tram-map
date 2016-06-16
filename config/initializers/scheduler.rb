unless defined?(Rails::Console) || File.split($0).include?('rake')
  Rails.application.scheduler.every '14s' do
    puts "#{Time.now}@Refreshing tram data"
    Tram.refresh_data
  end
end
