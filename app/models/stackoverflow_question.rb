class StackoverflowQuestion < ActiveRecord::Base
  attr_accessible :answer_count, :down_vote_count, :favorite_count, :is_answered, :last_activity_date, :last_edit_date, :question_created_at, :score, :stackoverflow_profile_id, :up_vote_count, :view_count
  
  has_many :answers, class_name: 'StackoverflowAnswer'
  
  belongs_to :profile, class_name: 'StackoverflowProfile'
end
