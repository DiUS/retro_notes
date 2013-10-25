class Retro
  include Mongoid::Document
  include Mongoid::Timestamps
  acts_as_api

  attr_accessible :title

  belongs_to :project
  has_many :retro_reflections
  # has_many :sentiment_quiz_responses

  field :title, type: String
  validates :title,
    presence: true,
    length: { maximum: 200 }

  api_accessible :default do |template|
    template.add :_id
    template.add :title
    template.add :retro_reflections
  end
end
