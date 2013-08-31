class CreateStackoverflowTags < ActiveRecord::Migration
  def change
    create_table :stackoverflow_tags do |t|
      t.string :name
      t.integer :count
      t.boolean :has_synonyms

      t.timestamps
    end
  end
end
