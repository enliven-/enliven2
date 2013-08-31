class CreateStackoverflowTaggings < ActiveRecord::Migration
  def change
    create_table :stackoverflow_taggings do |t|
      t.integer :stackoverflow_taggable_id
      t.integer :stackoverflow_tag_id
      t.string :stackoverflow_taggable_type
      
      t.timestamps
    end
  end
end
