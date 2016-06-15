Rails.application.scheduler.every '14s' do
  puts "Scheduler running task"
  Tram.refresh_data
end