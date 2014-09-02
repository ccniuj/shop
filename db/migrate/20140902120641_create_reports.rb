class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :email
      t.string :description
      t.boolean :is_question?
      t.timestamps
    end
  end
end
