class Project < ApplicationRecord

  belongs_to :user
  has_many   :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  def update_task_positions
    tasks.each do |t|
      t.update(position: t.position + 1)
    end
  end

  def sort_tasks(order)
    order.each do |k, v|
      tasks.find(k).update(position: v)
    end
  end

end