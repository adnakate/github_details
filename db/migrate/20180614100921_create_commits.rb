class CreateCommits < ActiveRecord::Migration[5.1]
  def change
    create_table :commits do |t|
      t.string :sha, index: true
      t.datetime :commit_date
      t.string :commit_message
      t.string :committer_username
      t.string :committer_id
      t.references :user, foreign_key: true, index: true
      t.references :repository, foreign_key: true, index: true
      t.timestamps
    end
  end
end
