require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/survey'
require './lib/question'
also_reload( './lib/**/*.rb')

get '/' do
  @questions = []
  @surveys = Survey.all
  Question.all.each do |q|
    if q.survey_id == @surveys[0].id
      @questions.push( q )
    end
  end
  @current_survey = ( @surveys[0].class != NilClass ) ? @surveys[0] : nil
  erb :index
end

get '/switch_survey' do
  @surveys = Survey.all
  @questions = []
  @current_survey = Survey.find(params.fetch("select_survey").to_i)
  Question.all.each do |q|
    if q.survey_id == @current_survey.id
      @questions.push( q )
    end
  end
  erb :index
end

get '/switch_survey/:survey_id' do
  @surveys = Survey.all
  @questions = []
  @current_survey = Survey.find(params[:survey_id].to_i)
  Question.all.each do |q|
    if q.survey_id == @current_survey.id
      @questions.push( q )
    end
  end
  erb :index
end

get '/create_form' do
  new_survey = Survey.create({ name: params.fetch("survey_name")})
  for question_inx in 0..params.fetch("number_of_questions").to_i - 1
    new_question = Question.create({question: "", survey_id: new_survey.id})
  end
  redirect '/'
end

patch '/update_question/:id/:survey_id' do
  question = Question.find(params[:id])
  question.update( {question: params.fetch("name")} )
  redirect '/switch_survey/' + params[:survey_id]
end

delete '/delete_survey/:id' do

  Survey.find(params[:id]).delete
  redirect '/'
end


delete '/delete_question/:id/:survey_id' do
  Question.find(params[:id]).delete
  question_count = 0
  Question.all.each do |q|
    if q.survey_id == Survey.find(params[:survey_id]).id
      question_count += 1
    end
  end
  if question_count == 0
    Survey.find(params[:survey_id]).delete
    redirect '/'
  else
    redirect '/switch_survey/' + params[:survey_id]
  end
end
