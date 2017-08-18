class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :project, index: true, foreign_key: { on_delete: :cascade }
      t.string :name
      t.boolean :completed, default: false
      t.string  :deadline, default: ''
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end