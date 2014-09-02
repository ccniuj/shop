class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :report_id
      t.integer :answer
      t.timestamps
    end
  end
end
