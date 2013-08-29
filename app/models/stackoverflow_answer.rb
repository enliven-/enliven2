class StackoverflowAnswer < ActiveRecord::Base
  attr_accessible :answer_created_at, :down_vote_count, :is_accepted, :last_activity_date, :last_edit_date, :score, :stackoverflow_profile_id, :stackoverflow_question_id, :up_vote_count
  
  belongs_to :question, class_name: 'StackoverflowQuestion'
  belongs_to :profile, class_name: 'StackoverflowProfile'
end
