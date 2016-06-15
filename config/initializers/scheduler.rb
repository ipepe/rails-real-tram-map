Rails.application.scheduler.every '10s' do
  puts "Scheduler running task"
  Tram.refresh_data
end