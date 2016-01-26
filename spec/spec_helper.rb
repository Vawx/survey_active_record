ENV['RACK_ENV'] = 'test'

require 'sinatra/activerecord'
require 'rspec'
require 'pg'
require 'survey'
require 'question'

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each do |pr|
      pr.destroy
    end
    Question.all.each do |qu|
      qu.destroy
    end
  end
end
