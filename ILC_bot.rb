#!/usr/bin/env ruby

#require 'byebug'
require 'yaml'
require 'twitter'
require 'holiday_japan'

def tweets?(date)
  return [false, ''] if date.saturday? || date.sunday? || date.national_holiday?
  next_friday = date.upto(date + 6).select { |d| d.friday? }.first
  tweet_day = next_friday.downto(next_friday - 4).reject { |d| d.national_holiday? }.first
  if date == tweet_day
    return [true, date.friday? ? '' : '※金曜日は祝日です']
  else
    [false, '']
  end
end

if __FILE__ == $0
  conf = YAML.load_file("#{File.dirname(__FILE__)}/config/#{ARGV[0]}.yml")

  client = Twitter::REST::Client.new do |c|
    c.consumer_key        = conf['consumer_key']
    c.consumer_secret     = conf['consumer_secret']
    c.access_token        = conf['access_token']
    c.access_token_secret = conf['access_token_secret']
  end

  t, m = tweets?(Date.today)

  if t
    succeed = false
    errors = []

    text = ['ILC', 'ILC。', 'ILC！', 'ILC……', 'ILC! ILC!', 'ILCです'][Date.today.yday % 6] + m
    3.times do
      begin
        client.update(text)
      rescue Twitter::Error => e
        errors << e.to_s
        sleep 1
      else
        succeed = true
        break
      end
    end

    # if all retweet attempts failed, put errors to STDERR
    unless succeed
      STDERR.puts 'All attempts have failed!'
      errors.each { |e| STDERR.puts e }
    end
  end
end
