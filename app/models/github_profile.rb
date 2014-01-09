class GithubProfile < ActiveRecord::Base
  attr_accessible :bio, :blog, :company, :followers_count, :following_count, :github_id, :hireable, :location, :name, :profile_created_at, :public_gists_count, :public_repos_count, :username, :followers, :following, :email
  
  include Enliven::Client
  
  has_many :repos, class_name: 'GithubRepo'
  has_many :gists, class_name: 'GithubGist'
  
  belongs_to :profile
  
  # Write methods to fetch data from SO's database using their api
  
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
                              forkers:         (github_client.forks(repo.full_name).map { |fork| fork.owner.login}.join(', ')),
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

   # Read methods for drawing graph

  def raw_score
    repos.inject(0) { |result, repo| result + repo.raw_score }
  end

  def creator?
    thresh_hold     = 2
    is_lib_flags    = repos.map { |repo| repo.lib? }
    is_creator      = is_lib_flags.inject(0) { |count, new_entry| count + (new_entry[0]==true ? 1 : 0) } > thresh_hold
    creator_score   = is_lib_flags.inject(0) { |count, new_entry| count + new_entry[1] }
    return is_creator, creator_score
  end

  def open_src_contributor?
    thresh_hold                 = 2
    is_open_src_contrbtn_flags  = repos.map { |repo| repo.open_src_contribution? }
    is_open_src_contributor     = is_open_src_contrbtn_flags.inject(0) { |count, new_entry| count + (new_entry[0]==true ? 1 : 0) } > thresh_hold
    open_src_contributor_score  = is_open_src_contrbtn_flags.inject(0) { |count, new_entry| count + new_entry[1] }
    return is_open_src_contributor, open_src_contributor_score 
  end

  def skilled?
    ave_thresh_hold   = 200
    prof_thresh_hold  = 2000
    prof_skill_score  = raw_score
    ave_skill_score   = raw_score / repos.length

    if prof_skill_score > prof_thresh_hold && ave_skill_score > ave_thresh_hold
      return true, prof_skill_score
    else
      return false, prof_skill_score
    end

  end

  def all_round_ninja?
    ave_thresh_hold = 400
    ind_thresh_hold = 200
    min_lang_count  = 4
    skill_score = raw_score / repos.length
    if skill_score > ave_thresh_hold
      return false, {}
    end

    selected_langs = {}
    repos.each do |repo|
      if repo.language and repo.raw_score > ind_thresh_hold
        if selected_langs[repo.language].present?
          selected_langs[repo.language] += repo.raw_score  
        else
          selected_langs[repo.language] = repo.raw_score
        end
      end
    end

    if selected_langs.length < min_lang_count
      return false, selected_langs
    else
      return true, selected_langs
    end

  end

  
end
