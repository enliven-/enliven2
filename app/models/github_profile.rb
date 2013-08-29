class GithubProfile < ActiveRecord::Base
  attr_accessible :bio, :blog, :company, :followers_count, :following_count, :github_id, :hireable, :location, :name, :profile_created_at, :public_gists_count, :public_repos_count, :username, :followers, :following, :email
  
  include Enliven::Client
  
  has_many :repos, class_name: 'GithubRepo'
  has_many :gists, class_name: 'GithubGist'
  
  belongs_to :profile
  
  def fetch_repos
    for repo in github_client.repositories(username)
      fetch_repo(repo)
    end
  end
  
  def fetch_repo(repo)
     self.repos.create!(
                              repo_id:         repo.id,
                              full_name:       repo.full_name,
                              language:        repo.language,
                              description:     repo.description,
                              fork:            repo.fork,
                              forks_count:     repo.forks_count,
                              watchers_count:  repo.watchers_count,
                              size:            repo.size,
                              repo_created_at: repo.created_at,
                              forkers:          (github_client.forks(repo.full_name).map { |fork| fork.owner.login}.join(', ')),
                              watchers:        (github_client.watchers(repo.full_name).map { |watcher| watcher.login}.join(', ')),
                              contributors:    (github_client.contributors(repo.full_name).map { |contributor| contributor.login }.join(', ')),
                              collaborators:   (github_client.collaborators(repo.full_name).map { |collaborator| collaborator.login }.join(', '))
                              ).fetch_commits
  rescue Exception => e
    warn "============================================ Error here"
    warn e.inspect
    warn repo.inspect
    warn "======================================================="
  end
  
  def fetch_gists
    for gist in github_client.gists(username)
      fetch_gist(gist)
    end
  end
  
  # def fetch_gist(gist)
#     gist = github_client.gist gist.id
#     self.github_gists.create(
#     github_gist_id:  gist.id,
#     gist_created_at: gist.created_at, 
#     forkers:         (gist.forks.map { |fork| fork.user.login })
#     )
#   end
#   
#   def gist_languages(gist)
#     gist.files.
#   end
  
end
