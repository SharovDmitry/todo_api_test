class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :task, index: true, foreign_key: { on_delete: :cascade }
      t.string :content
      t.string :image, default: ''

      t.timestamps
    end
  end
end