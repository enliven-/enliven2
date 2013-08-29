class StackoverflowTag < ActiveRecord::Base
  attr_accessible :label
  
  has_many :profiles, through: :taggings, source: :taggable, source_type: "StackoverflowProfile"
  has_many :taggings
end
