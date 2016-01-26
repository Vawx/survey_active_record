ENV['RACK_ENV'] = 'test'

require 'sinatra/activerecord'
require 'rspec'
require 'pg'
require 'survey'

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each do |pr|
      pr.destroy
    end
  end
end
