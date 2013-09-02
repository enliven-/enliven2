class StackoverflowBadge < ActiveRecord::Base
  attr_accessible :name, :rank, :badge_type
  
  has_many :stackoverflow_profile_badges
  has_many :stackoverflow_profiles, through: :stackoverflow_profile_badges
  alias_method :profiles, :stackoverflow_profiles
  
end
