class CreateStackoverflowAnswers < ActiveRecord::Migration
  def change
    create_table :stackoverflow_answers do |t|
      t.integer :stackoverflow_question_id
      t.datetime :answer_created_at
      t.datetime :last_edit_date
      t.datetime :last_activity_date
      t.integer :score
      t.boolean :is_accepted
      t.integer :up_vote_count
      t.integer :down_vote_count
      t.integer :stackoverflow_profile_id

      t.timestamps
    end
  end
end
