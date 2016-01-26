
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe 'the create survey path', {:type => :feature} do
  it 'creates a new survey' do
    visit '/'
    fill_in 'number_of_questions', :with => 1
    fill_in 'survey_name', :with => "ask me anything"
    click_button 'Make Form'
    expect(page).to have_content("ask me anything")
  end
end
