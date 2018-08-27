class CreateTaskDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :task_details do |t|
      t.string :description, null: false
      t.boolean :completed, null: false, default: false
      t.belongs_to :task, foreign_key: true

      t.timestamps
    end
  end
end
