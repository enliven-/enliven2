class StackoverflowTag < ActiveRecord::Base
  attr_accessible :label
  
  has_many :profiles, through: :stackoverflow_taggings, source: :stackoverflow_taggable, source_type: "StackoverflowProfile"
  has_many :questions, through: :stackoverflow_taggings, source: :stackoverflow_taggable, source_type: "StackoverflowQuestion"
   has_many :answers, through: :stackoverflow_taggings, source: :stackoverflow_taggable, source_type: "StackoverflowAnswer"
  has_many :stackoverflow_taggings
end
