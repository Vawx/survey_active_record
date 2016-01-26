require 'sinatra/activerecord'

class Survey < ActiveRecord::Base
  has_many :questions
end
