class GithubDetailsController < ApplicationController
  before_action :ensure_logged_in, only: [:repositories]
  require 'httparty'
  # home page
  def home
    
  end

  # user repositories
  def repositories
    url = 'https://api.github.com/users/'
    response = HTTParty.get(url + current_user.username + '/repos')
    @repositories = Repository::RepositoryDetailsIntr.run!(user: current_user, repositories: response.parsed_response)
  end
end
