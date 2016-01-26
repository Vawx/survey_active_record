require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/survey'
require './lib/question'
also_reload( './lib/**/*.rb')

get '/' do
  erb :index
end
