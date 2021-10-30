class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.string :content
      t.string :doneness
      t.timestamps null: false
    end
  end
end
