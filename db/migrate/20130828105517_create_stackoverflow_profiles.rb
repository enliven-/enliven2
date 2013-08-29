class CreateStackoverflowProfiles < ActiveRecord::Migration
  def change
    create_table :stackoverflow_profiles do |t|
      t.string :profile_type
      t.datetime :creation_date
      t.string :name
      t.integer :reputation_change_day
      t.integer :reputation_change_week
      t.integer :reputation_change_month
      t.integer :reputation_change_quarter
      t.integer :reputation_change_year
      t.integer :age
      t.datetime :last_access_date
      t.datetime :last_modified_date
      t.boolean :is_employee
      t.string :blog
      t.string :location
      t.integer :account_id
      t.integer :accept_rate
      t.integer :gold_badge_count
      t.integer :silver_badge_count
      t.integer :bronze_badge_count
      t.integer :reputation
      t.integer :answer_count
      t.integer :question_count
      t.integer :view_count
      t.text :about_me

      t.timestamps
    end
  end
end
