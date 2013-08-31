class StackoverflowProfile < ActiveRecord::Base
  attr_accessible :stackoverflow_profile_id, :about_me, :accept_rate, :account_id, :age, :answer_count, :blog, :bronze_badge_count, :gold_badge_count, :is_employee, :last_access_date, :last_modified_date, :location, :name, :creation_date, :profile_type, :question_count, :reputation_change_day, :reputation_change_month, :reputation_change_quarter, :reputation_change_week, :reputation_change_year, :reputation, :silver_badge_count, :view_count
  
  has_many :questions, class_name: 'StackoverflowQuestion'
  has_many :answers, class_name: 'StackoverflowAnswer'
  has_many :comments, class_name: 'StackoverflowComment'
  
  has_many :stackoverflow_profile_badges
  has_many :stackoverflow_badges, through: :stackoverflow_profile_badges

  has_many :stackoverflow_tags, through: :stackoverflow_taggings
  has_many :stackoverflow_taggings, as: :stackoverflow_taggable
  alias_method :tags, :stackoverflow_tags
  alias_method :taggings, :stackoverflow_taggings
  
  def fetch_questions(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    while(has_more) do
      questions = user.questions.pagesize(100).page(page).get
      for question in questions
        self.questions.create(
                                id:                  question.id,
                                last_edit_date:      question.last_edit_date,
                                question_created_at: question.creation_date,
                                last_activity_date:  question.last_activity_date,
                                score:               question.score,
                                answer_count:        question.answer_count,
                                up_vote_count:       question.up_vote_count,
                                down_vote_count:     question.down_vote_count,
                                favorite_count:      question.favorite_count,
                                view_count:          question.view_count,
                                is_answered:         question.is_answered
                             )
      end
      has_more = questions.has_more
      page += 1
    end
  end
  
  def fetch_answers(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    while(has_more) do
      answers = user.answers.pagesize(100).page(page).get
      for answer in answers
        self.answers.create(
        id: answer.id,
        answer_created_at: answer.creation_date,
        last_edit_date: answer.last_edit_date,
        last_activity_date: answer.last_activity_date,
        score: answer.score,
        is_accepted: answer.is_accepted,
        up_vote_count: answer.up_vote_count,
        down_vote_count: answer.down_vote_count
        )
      end
      has_more = answers.has_more
      page += 1
    end
  end
  
  def fetch_tags(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    tags = []
    while(has_more) do
      so_tags = user.tags.pagesize(100).page(page).get
      for tag in so_tags
        tags << StackoverflowTag.find_or_create_by_name(tag.name).tap do |t|
                  t.count ||= tag.try(:count) 
                  t.has_synonyms ||= tag.try(:has_synonyms)
                  t.name = tag.name
                end
      end
      has_more = so_tags.has_more
      page += 1 
    end
    self.stackoverflow_tags = tags
    self.save
  end
  
  def fetch_badges(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    while(has_more) do
      badges = user.badges.pagesize(100).page(page).get
      for badge in badges
        so_badge = StackoverflowBadge.find_or_create_by_id(badge.id) do |b|
                    b.name = badge.name
                    b.rank = badge.rank
                   end
        StackoverflowProfileBadge.create(stackoverflow_profile_id: id, stackoverflow_badge_id: so_badge.id, award_count: badge.award_count)
      end
      has_more = badges.has_more
      page += 1 
    end
  end
  
  def fetch_comments(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    while(has_more) do
      comments = user.comments.pagesize(100).page(page).get
      for comment in comments
        self.comments.create(id: comment.id, edited: comment.edited, score: comment.score, creation_date: comment.creation_date, stackoverflow_post_id: comment.post_id)
      end
      has_more = comments.has_more
      page += 1 
    end
  end
  
end
