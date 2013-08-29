class Profile < ActiveRecord::Base
  attr_accessible :email, :github_profile_id, :so_profile_id
  
  has_one :github_profile
  #has_one :so_profile
end
