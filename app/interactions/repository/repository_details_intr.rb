class Repository::RepositoryDetailsIntr < ActiveInteraction::Base
  object :user, class: 'User', presence: true
  array :repositories

  def execute
    create_repositories
    user_repositories
  end

  private

  # create entry for repositories if not present in database
  def create_repositories
    present_repo_ids = user.repositories.pluck(:repo_id)
    repo_details = repositories.inject([]) do |repo_hash, repo|
      repo_hash << get_repo_hash(repo) unless present_repo_ids.include?(repo['id'].to_s)
    end
    Repository.bulk_insert values: repo_details
  end

  def get_repo_hash(repo)
    { repo_id: repo['id'], name: repo['name'], description: repo['description'],  repo_created_at: repo['created_at'].to_datetime,
      repo_updated_at: repo['updated_at'].to_datetime, pushed_at: repo['pushed_at'].to_datetime, user_id: user.id }
  end

  # get repositories of user
  def user_repositories
    user.repositories
  end
end