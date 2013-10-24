class SentimentQuiz
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :sentiment_quiz_responses

  attr_accessible :title

  belongs_to :project

  field :title, type: String
  validates :title,
    presence: true
end
