class StackoverflowQuestion < ActiveRecord::Base
  attr_accessible :stackoverflow_question_id,:answer_count, :down_vote_count, :favorite_count, :is_answered, :last_activity_date, :last_edit_date, :question_created_at, :score, :stackoverflow_profile_id, :up_vote_count, :view_count
  
  has_many :stackoverflow_tags, through: :stackoverflow_taggings
  has_many :stackoverflow_taggings, as: :stackoverflow_taggable
  alias_method :tags, :stackoverflow_tags
  alias_method :taggins, :stackoverflow_taggings
  
  belongs_to :profile, class_name: 'StackoverflowProfile'
end
