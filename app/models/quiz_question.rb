class QuizQuestion
  include Mongoid::Document

  attr_accessible :question

  embedded_in :sentiment_quiz

  field :question, type: String
  validates :question,
    presence: true
end
