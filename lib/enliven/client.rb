module Enliven
  module Client
  
    def github_client
      client_id = ENV['github_client_id'] || 'c03d26e3153e26665712'
      client_secret = ENV['github_client_secret'] || 'd3015abeccfb46ef447f5731cc5679505d688cce'
      @github_client = @github_client || Octokit::Client.new(client_id: client_id, client_secret: client_secret)
    end
    
    def so_client
      Serel::Base.config(:stackoverflow, (ENV['stackoverflow_api_key'] || 'jlBUUjz0K70aJHCJpAzOUg(('))
    end
  
  end
end