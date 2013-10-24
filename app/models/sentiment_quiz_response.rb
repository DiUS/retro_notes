class SentimentQuizResponse
  include Mongoid::Document

  belongs_to :sentiment_quiz
  belongs_to :feedback_session
  belongs_to :user
end
