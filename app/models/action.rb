class Action
  include Mongoid::Document
  acts_as_api

  belongs_to :retro

  attr_accessible :content, :retro_id, :resolved

  field :content, type: String
  field :resolved, type: Boolean
  validates :content,
    presence: true,
    length: { maximum: 1000 }

  api_accessible :default do |template|
    template.add :_id
    template.add :content
    template.add :resolved
  end
end
