class Project
  include Mongoid::Document
  acts_as_api

  has_many :retros
  has_many :sentiment_quizes

  attr_accessible :title

  field :title, type: String
  validates :title,
    presence: true,
    length: { maximum: 200 }
end
