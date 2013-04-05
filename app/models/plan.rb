class Plan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  has_many :cards
end
