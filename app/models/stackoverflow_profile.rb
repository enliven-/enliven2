class StackoverflowProfile < ActiveRecord::Base
  attr_accessible :stackoverflow_profile_id, :about_me, :accept_rate, :account_id, :age, :answer_count, :blog, :bronze_badge_count, :gold_badge_count, :is_employee, :last_access_date, :last_modified_date, :location, :name, :creation_date, :profile_type, :question_count, :reputation_change_day, :reputation_change_month, :reputation_change_quarter, :reputation_change_week, :reputation_change_year, :reputation, :silver_badge_count, :view_count
  
  has_many :questions, class_name: 'StackoverflowQuestion', dependent: :destroy
  has_many :answers, class_name: 'StackoverflowAnswer', dependent: :destroy
  has_many :comments, class_name: 'StackoverflowComment', dependent: :destroy
  
  has_many :stackoverflow_profile_badges, dependent: :destroy
  has_many :stackoverflow_badges, through: :stackoverflow_profile_badges
  alias_method :badges, :stackoverflow_badges

  has_many :stackoverflow_tags, through: :stackoverflow_taggings
  has_many :stackoverflow_taggings, as: :stackoverflow_taggable, dependent: :destroy
  alias_method :tags, :stackoverflow_tags
  alias_method :taggings, :stackoverflow_taggings
  
  # Write methods to fetch data from SO's database using their api
  
  def fetch_questions(user = nil)
    user ||= Serel::User.find(id)
    page = 1
    has_more = true
    while(has_more) do
      questions = user.questions.pagesize(100).page(page).get
      for question in questions
        q = self.questions.create(
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
         for tag in question.tags
           tags << StackoverflowTag.find_or_create_by_name(tag)
         end
         q.stackoverflow_tags = tags
         q.save                    
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
        a = self.answers.create(
        id:                        answer.id,
        answer_created_at:         answer.creation_date,
        last_edit_date:            answer.last_edit_date,
        last_activity_date:        answer.last_activity_date,
        score:                     answer.score,
        is_accepted:               answer.is_accepted,
        up_vote_count:             answer.up_vote_count,
        down_vote_count:           answer.down_vote_count,
        stackoverflow_question_id: answer.question_id
        )
        question = Serel::Question.find answer.question_id
        for tag in question.tags
          tags << StackoverflowTag.find_or_create_by_name(tag)
        end
        a.stackoverflow_tags = tags
        a.save   
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
        tags << StackoverflowTag.find_or_create_by_name(tag.name)
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
  
  # Read methods for drawing graph
  
  def raw_score
    reputation
  end
  
  # Returns the number of questions for each tag
  # example output:
  #     {"c#"=>13, "java"=>19, "android"=>14, "asp.net"=>7, "azure-worker-roles"=>9, "web-services"=>9 }
  #     where key is tag#name and value is number of questions
  def questions_by_tags
    tag_count = {}
    for question in questions
      for tag in question.tags.pluck(:name)
        tag_count[tag] = tag_count[tag].present? ? tag_count[tag] + 1 : 1
      end
    end
    tag_count
  end
  
  # Returns the number of times tags used by profile
  # example output: 
  #      {"c#"=>2, "java"=>2, "android"=>2, "asp.net"=>1}
  #      where key is tag#name and value is number of repetation
  def tags_count
    tag_count = {}
    for tag in tags.pluck(:name)
      tag_count[tag] = tag_count[tag].present? ? tag_count[tag] + 1 : 1
    end
    tag_count
  end
  
  def answers_by_tags
    tag_count = {}
    for answer in answers
      for tag in answer.tags.pluck(:name)
        tag_count[tag] = tag_count[tag].present? ? tag_count[tag] + 1 : 1
      end
    end
    tag_count
  end
  
end
