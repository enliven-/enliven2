module Enliven
  class StackoverflowSucker
    
    def user(id = nil)
      id = id || (rand(100000)+1)
      user = Serel::User.find(id)
      if user
        StackoverflowProfile.create(
                                    id:                        id,
                                    name:                      user.display_name,
                                    profile_type:              user.user_type,
                                    creation_date:             user.creation_date,
                                    reputation_change_day:     user.reputation_change_day,
                                    reputation_change_week:    user.reputation_change_week,
                                    reputation_change_month:   user.reputation_change_month,
                                    reputation_change_quarter: user.reputation_change_quarter,
                                    reputation_change_year:    user.reputation_change_year,
                                    age:                       user.age,
                                    last_access_date:          user.last_access_date,
                                    last_modified_date:        user.last_modified_date,
                                    is_employee:               user.is_employee,
                                    blog:                      user.website,
                                    localtion:                 user.location,
                                    account_id:                user.account_id,
                                    accept_rate:               user.accept_rate,
                                    gold_badge_count:          user.badge_counts['gold'],
                                    silver_badge_count:        user.badge_counts['silver'],
                                    bronze_badge_count:        user.badge_counts['bronze'],
                                    reputation:                user.reputation,
                                    answer_count:              user.answer_count,
                                    question_count:            user.question_count,
                                    view_count:                user.view_count,
                                    about_me:                  user.about_me
                                  )
      end
    end
  end
end