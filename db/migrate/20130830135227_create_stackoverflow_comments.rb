class CreateStackoverflowComments < ActiveRecord::Migration
  def change
    create_table :stackoverflow_comments do |t|
      t.integer :stackoverflow_profile_id
      t.integer :stackoverflow_post_id
      t.integer :score
      t.datetime :creation_date
      t.boolean :edited

      t.timestamps
    end
  end
end
