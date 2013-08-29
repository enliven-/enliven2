class GithubRepo < ActiveRecord::Base
  attr_accessible :description, :fork, :forks_count, :full_name, :language, :private, :repo_created_at, :repo_id, :size, :watchers_count, :watchers, :collaborators, :contributors, :forkers
  
  include Enliven::Client
  
  has_many :commits, class_name: 'GithubCommit'
  
  belongs_to :profile, class_name: 'GithubProfile'
  
  def name
    full_name.split('/').last
  end
  
  def fetch_commits
    for commit in github_client.commits full_name
      fetch_commit(commit)
    end
  end
  
  def fetch_commit(commit)
    commit = github_client.commit full_name, commit.sha
    self.commits.create(
                                sha:               commit.sha,
                                committer:         (commit.committer.login if commit.committer),
                                commit_created_at: commit.commit.committer.date,
                                additions:         commit.stats.additions,
                                deletions:         commit.stats.deletions
                              )
  rescue Octokit::TooManyRequests
    warn "Opps request limit reached"
    sleep(github_client.rate_limit.resets_in)                           
  rescue Exception => e
    warn "============================================ Error here"
    warn e.inspect
    warn commit.inspect
    warn "======================================================="
  end
end
