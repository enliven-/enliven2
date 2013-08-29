class CreateStackoverflowQuestions < ActiveRecord::Migration
  def change
    create_table :stackoverflow_questions do |t|
      t.datetime :last_edit_date
      t.datetime :question_created_at
      t.datetime :last_activity_date
      t.integer :score
      t.integer :answer_count
      t.integer :up_vote_count
      t.integer :down_vote_count
      t.integer :favorite_count
      t.integer :view_count
      t.integer :stackoverflow_profile_id
      t.boolean :is_answered

      t.timestamps
    end
  end
end
