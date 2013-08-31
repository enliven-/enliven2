class StackoverflowComment < ActiveRecord::Base
  attr_accessible :creation_date, :edited, :score, :stackoverflow_post_id, :stackoverflow_profile_id
  
  belongs_to :profile, class_name: 'StackoverflowProfile'
end
