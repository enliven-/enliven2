class CreateGithubGists < ActiveRecord::Migration
  def change
    create_table :github_gists do |t|
      t.datetime :gist_created_at
      t.string :language
      t.integer :size
      t.text :forkers
      t.boolean :public
      t.integer :github_profile_id
      t.integer :github_gist_id

      t.timestamps
    end
  end
end
