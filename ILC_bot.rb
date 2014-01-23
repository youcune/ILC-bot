#!/usr/bin/env ruby

#require 'byebug'
require 'logger'
require 'yaml'
require 'twitter'
require 'holiday_japan'

def tweets?(date)
  return [false, ''] if date.saturday? || date.sunday? || date.national_holiday?
  next_friday = [date .. date + 6].select { |d| d.friday? }.first
  tweet_day = [next_friday .. next_friday - 4].reject { |d| d.national_holiday? }.first
  if date == tweet_day
    return [true, date.friday? ? '' : '※明日は祝日です']
  end
end

if __FILE__ == $0
  conf = YAML.load_file("#{File.dirname(__FILE__)}/config/#{ARGV[0]}.yml")

  client = Twitter::REST::Client.new do |c|
    c.consumer_key        = conf['twitter']['consumer_key']
    c.consumer_secret     = conf['twitter']['consumer_secret']
    c.access_token        = conf['twitter']['access_token']
    c.access_token_secret = conf['twitter']['access_token_secret']
  end

  query = conf['search_queries'].sample
  succeed = false

  3.times do
    begin
      client.update(tweet)
    rescue Twitter::Error => e
      # do nothing, try again
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
