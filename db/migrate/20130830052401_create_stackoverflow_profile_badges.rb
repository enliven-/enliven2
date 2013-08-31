class CreateStackoverflowProfileBadges < ActiveRecord::Migration
  def change
    create_table :stackoverflow_profile_badges do |t|
      t.integer :stackoverflow_profile_id
      t.integer :stackoverflow_badge_id
      t.integer :award_count

      t.timestamps
    end
  end
end
