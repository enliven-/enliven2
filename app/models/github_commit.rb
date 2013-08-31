class GithubCommit < ActiveRecord::Base
  attr_accessible :additions, :commit_created_at, :committer, :deletions, :sha
  
  include Enliven::Client
  
  belongs_to :repo, class_name: 'GithubRepo'
  
  def total
    additions + deletions
  end
end
