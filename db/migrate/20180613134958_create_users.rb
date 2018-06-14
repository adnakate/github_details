class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :uid
      t.string :provider
      t.integer :public_repos
      t.string :username
      t.timestamps
    end
  end
end
