Rails.application.scheduler.every '4s' do
  puts "Scheduler running task"
  Tram.refresh_data
end