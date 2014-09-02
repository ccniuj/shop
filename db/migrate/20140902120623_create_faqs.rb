class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question
      t.stirng :answer
      t.timestamps
    end
  end
end
