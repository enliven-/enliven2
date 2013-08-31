class StackoverflowProfileBadge < ActiveRecord::Base
  attr_accessible :award_count, :stackoverflow_badge_id, :stackoverflow_profile_id
  
  belongs_to :stackoverflow_profile
  belongs_to :stackoverflow_badge
end
