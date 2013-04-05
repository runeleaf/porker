class Card
  include Mongoid::Document
  include Mongoid::Timestamps

  field :point, type: Integer
  field :note, type: String
  belongs_to :plan
end
