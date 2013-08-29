class CreateGithubRepos < ActiveRecord::Migration
  def change
    create_table :github_repos do |t|
      t.integer :repo_id
      t.string :full_name
      t.text :description
      t.boolean :private, default: false
      t.boolean :fork
      t.string :language
      t.integer :forks_count
      t.integer :watchers_count
      t.integer :size
      t.text :watchers
      t.text :contributors
      t.text :collaborators
      t.text :forkers
      t.integer :github_profile_id
      t.datetime :repo_created_at

      t.timestamps
    end
  end
end
