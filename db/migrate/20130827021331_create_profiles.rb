class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :email
      t.integer :github_profile_id
      t.integer :so_profile_id

      t.timestamps
    end
  end
end
