# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Update the crontab: bundle exec whenever --update-crontab
# Clear the crontab: crontab -r
# Edit the crontab: crontab -e
# Update the cron development: bundle exec whenever --update-crontab --set environment='development'

set :output, 'log/cron.log'

every 1.minutes do
  runner "puts 'Time.now'"
  runner "puts 'Rails.env'"
  runner "puts 'Hello World'"
end

# Learn more: http://github.com/javan/whenever
