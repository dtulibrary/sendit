Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
Delayed::Worker.sleep_delay         = 60
Delayed::Worker.destroy_failed_jobs = false
