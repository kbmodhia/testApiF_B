class CreateGroupKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :group_keywords do |t|
      t.string :groupid
      t.string :userid
      t.string :keyword

      t.timestamps
    end
  end
end
