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

  def commit_activity
    commits_log = []
    commits.each do |c|
      commit = { ts: c.commit_created_at, adds: c.additions, dels: c.deletions }
      commits_log << commit
    end
    commits_log
  end

  def repo_raw_score
    size + watchers_count + collaborators.length + contributors.length + forkers.length
  end


  def commits_score
    total = 0
    commit_activity.each do |c|
      total += c[:adds] - c[:dels]/2.0
    end
    total
  end


  # def repo_score
  #   score = 0

  #   forkers_logins = forkers.split(',')
  #   forkers = forkers_logins.map { |f_login| GithubProfile.find("login?", f_login) }
  #   forkers.inject(score) { |result, f| result + f.prof_raw_score }
  # end


  def osc?
    return (fork and (repo_raw_score>500) and (size>200)), repo_raw_score-500+size-200
  end

  def lib?
    return ((repo_raw_score>500) and (not fork)), repo_raw_score-500+size-200
  end

end
