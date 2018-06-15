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

  # user commits
  def commits
    url = 'https://api.github.com/repos/'
    response = HTTParty.get(url + current_user.username + '/' + params[:repo_name] + '/commits')
    @commits = Repository::CommitsIntr.run!(user: current_user, commits: response.parsed_response, repository_name: params[:repo_name])
    @repo_name = params[:repo_name]
  end
end

