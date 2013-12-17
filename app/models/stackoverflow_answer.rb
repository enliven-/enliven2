class StackoverflowAnswer < ActiveRecord::Base
  attr_accessible :answer_created_at, :down_vote_count, :is_accepted, :last_activity_date, :last_edit_date, :score, :stackoverflow_profile_id, :up_vote_count
  
  belongs_to :profile, class_name: 'StackoverflowProfile'
  
  has_many :stackoverflow_tags, through: :stackoverflow_taggings
  has_many :stackoverflow_taggings, as: :stackoverflow_taggable, dependent: :destroy
  alias_method :tags, :stackoverflow_tags
  alias_method :taggings, :stackoverflow_taggings
  
  
  def self.tagss
    StackoverflowAnswer.find_each do |answer|
      answer.stackoverflow_question_id = Serel::Answer.find(answer.id).question_id
      question = Serel::Question.find answer.stackoverflow_question_id
      tags = []
      for tag in question.tags
        tags << StackoverflowTag.find_or_create_by_name(tag)
      end
      answer.stackoverflow_tags = tags
      answer.save   
    end
  end
end
