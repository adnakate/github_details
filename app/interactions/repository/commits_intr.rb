class Repository::CommitsIntr < ActiveInteraction::Base
  object :user, class: 'User', presence: true
  array :commits
  string :repository_name, presence: true

  def execute
    create_commits
    get_commits
  end

  private

  # create entry for commits if not present in database
  def create_commits
    present_commits = user.repositories.find_by(name: repository_name).commits.pluck(:sha)
    commits_details = []
    commits.each do |commit|
      commits_details << get_commit_hash(commit) unless present_commits.include?(commit['sha'])
    end
    Commit.bulk_insert values: commits_details
  end

  def get_commit_hash(commit) 
    { sha: commit['sha'], commit_date: commit['commit']['committer']['date'].to_date, commit_message: commit['commit']['message'],
      committer_username: commit['committer']['login'], committer_id: commit['committer']['id'].to_s, user_id: user.id,
      repository_id: user.repositories.find_by(name: repository_name).id }
  end

  # get user commits
  def get_commits
    user_commits = user.repositories.find_by(name: repository_name).commits.group('commit_date').count
    commits_hash = []
    user_commits.each do |commit|
      commits_hash << { date: get_commit_date(commit.first), commit_count: commit.last }
    end
    commits_hash
  end

  def get_commit_date(commit_date)
    Date.parse(commit_date.to_s).strftime('%d') + '-'+ Date.parse(commit_date.to_s).strftime('%b') + '-' + Date.parse(commit_date.to_s).strftime('%y')
  end
end