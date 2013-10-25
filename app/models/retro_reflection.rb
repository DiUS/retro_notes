class RetroReflection
  include Mongoid::Document
  acts_as_api

  belongs_to :retro
  has_many :retro_responses

  attr_accessible :title

  field :title, type: String
  validates :title,
    presence: true,
    length: { maximum: 200 }

  api_accessible :default do |template|
    template.add :_id
    template.add :title
    template.add :retro_responses
  end
end
