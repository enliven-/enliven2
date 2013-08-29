class CreateGithubCommits < ActiveRecord::Migration
  def change
    create_table :github_commits do |t|
      t.string :sha
      t.string :committer
      t.datetime :commit_created_at
      t.integer :additions
      t.integer :deletions
       t.integer :github_repo_id

      t.timestamps
    end
  end
end
