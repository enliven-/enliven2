class CreateStackoverflowBadges < ActiveRecord::Migration
  def change
    create_table :stackoverflow_badges do |t|
      t.string :name
      t.string :rank
      t.string :badge_type

      t.timestamps
    end
  end
end
