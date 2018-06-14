class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :repo_id, index: true
      t.string :name
      t.string :description
      t.datetime :repo_created_at
      t.datetime :repo_updated_at
      t.datetime :pushed_at
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
