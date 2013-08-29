class CreateStackoverflowTags < ActiveRecord::Migration
  def change
    create_table :stackoverflow_tags do |t|
      t.string :label

      t.timestamps
    end
  end
end
