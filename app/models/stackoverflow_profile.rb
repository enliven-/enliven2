class StackoverflowProfile < ActiveRecord::Base
  attr_accessible :about_me, :accept_rate, :account_id, :age, :answer_count, :blog, :bronze_badge_count, :gold_badge_count, :is_employee, :last_access_date, :last_modified_date, :location, :name, :creation_date, :profile_type, :question_count, :reputation_change_day, :reputation_change_month, :reputation_change_quarter, :reputation_change_week, :reputation_change_year, :reputation, :silver_badge_count, :view_count
  
  has_many :questions, class_name: 'StackoverflowQuestion'
  has_many :answers, class_name: 'StackoverflowAnswers'

  has_many :tags, through: :taggings
  has_many :taggings, through: :taggable
  
  def fetch_questions
    
  end
end
