timer = if Rails.env.development?
          '1m'
        else
          '10s'
        end
Rails.application.scheduler.every '10s' do
  puts "Scheduler running task"
  Tram.refresh_data
end