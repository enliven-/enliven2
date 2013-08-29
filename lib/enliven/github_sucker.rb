module Enliven
  class GithubSucker
    include Enliven::Client
    
    def users(start_id = nil)
      since = start_id || rand(100000)
      for u in github_client.all_users(since: since)
        begin
          user = github_client.user u.login
          github_profile = GithubProfile.create(username:            user.login,
                                                email:               user.email,
                                                github_id:           user.id,
                                                name:                user.name,
                                                bio:                 user.bio,
                                                company:             user.company,
                                                blog:                user.blog,
                                                location:            user.location,
                                                hireable:            user.hireable,
                                                public_repos_count:  user.public_repos,
                                                public_gists_count:  user.public_gists,
                                                followers_count:     user.followers,
                                                following_count:     user.following,
                                                profile_created_at:  user.created_at,
                                                followers:           (github_client.followers(user.login).map { |follower| follower.login }.join(', ')),
                                                following:           (github_client.following(user.login).map { |follower| follower.login }.join(', '))
                                               )
          Profile.create email: github_profile.email, github_profile_id: github_profile.id
          github_profile.fetch_repos
        rescue Octokit::TooManyRequests
          warn "Opps request limit reached"
          sleep(github_client.rate_limit.resets_in)
        rescue Exception => e
          warn "============================================ Error here"
          warn e.inspect
          warn u.inspect
          warn "======================================================="
        end
      end
    end
    
  end
end