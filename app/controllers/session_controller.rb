class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  
  #create user session
  def create
    user = create_or_find_user
    session[:user_id] = user.id
    redirect_to :github_details_repositories
  end

  #destroy user sessoin
  def destroy
    reset_session
    redirect_to :root
  end

  private

  # return user if already present else create new user
  def create_or_find_user
    User.find_or_create_by(provider: auth_hash['provider'], uid: auth_hash['uid']) do |user|
      user.email = auth_hash['info']['email']
      user.name = auth_hash['info']['name']
      user.username =  auth_hash['extra']['raw_info']['login']
      user.public_repos = auth_hash['extra']['raw_info']['public_repos']
    end
  end

  # get hash from github provider
  def auth_hash
    request.env['omniauth.auth']
  end
end
