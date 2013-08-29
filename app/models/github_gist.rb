class GithubGist < ActiveRecord::Base
  attr_accessible :forkers, :gist_created_at, :github_gist_id, :github_profile_id, :language, :public, :size
end
