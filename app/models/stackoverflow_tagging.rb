class StackoverflowTagging < ActiveRecord::Base
  belongs_to :stackoverflow_tag
  belongs_to :stackoverflow_taggable, polymorphic: true
end
