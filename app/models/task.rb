class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :position, presence: true
  validates :deadline, format: { with: /\A(\d{2}[.]\d{2}[.]\d{4}|^$)\z/,
                                 message: 'Invalid format' }
  validates_inclusion_of :completed, in: [true, false]
end