unless defined?(Rails::Console) || File.split($0).last == 'rake'
  Rails.application.scheduler.every '4s' do
    puts "Scheduler running task"
    Tram.refresh_data
  end
end
