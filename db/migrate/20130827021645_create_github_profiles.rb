class CreateGithubProfiles < ActiveRecord::Migration
  def change
    create_table :github_profiles do |t|
      t.string :username
      t.string :email
      t.string :name
      t.integer :github_id
      t.string :company
      t.string :blog
      t.string :location
      t.boolean :hireable
      t.text :bio
      t.integer :public_repos_count
      t.integer :public_gists_count
      t.integer :followers_count
      t.integer :following_count
      t.boolean :fetched
      t.text :followers
      t.text :following
      t.datetime :profile_created_at

      t.timestamps
    end
  end
end
