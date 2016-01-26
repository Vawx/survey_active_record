require 'spec_helper'


describe Survey do
  describe "#new" do
    it 'creates a new survey object' do
      survey = Survey.create( {name: "NewSurvey"} )
      expect(survey.name).to(eq("NewSurvey"))
    end
  end
  describe "#question" do
    it 'creates a survey and question' do
      survey = Survey.create( {name: "New Survey"} )
      question = Question.create( {question: "does this work?", survey_id: survey.id} )
      expect(survey.questions).to(eq([question]))
    end
  end
  describe "#questions" do
    it 'creates a survey and questions' do
      survey = Survey.create( {name: "New Survey"} )
      question_one = Question.create( {question: "does this work?", survey_id: survey.id} )
      question_two = Question.create( {question: "yes it does", survey_id: survey.id} )
      expect(survey.questions).to(eq([question_one, question_two]))
    end
  end
end

describe Question do
  describe "#new" do
    it 'creates a new question object' do
      question = Question.create( {question: "yes?", survey_id: 1} )
      expect(question.question).to(eq("yes?"))
    end
  end
  describe "#survey" do
    it 'creates a survey and question and make sure survey_id of question matches survey.id' do
      survey = Survey.create( {name: "New Survey"} )
      question = Question.create( {question: "yes?", survey_id: survey.id})
      expect(question.survey_id).to(eq(survey.id))
    end
  end
end
