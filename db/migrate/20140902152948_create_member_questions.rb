class CreateMemberQuestions < ActiveRecord::Migration
  def change
    create_table :member_questions do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :status
      t.timestamps
    end
  end
end
