class GithubProfilesController < ApplicationController

  def index
  end
  
  def commit_activity
    profile = GithubProfile.find(params[:id])
    render json: profile.repos.last.commit_activity
  end

end
