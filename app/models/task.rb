class Task < ApplicationRecord
  belongs_to :user
 
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :by_due_date, -> { order(due_date: :asc) }
  scope :not_due, -> { where(due_date: nil) }
  scope :past_due, -> { where("due_date < ?", Date.today) }
  scope :due_soon, -> { where("due_date >= ? and due_date <= ?", Date.today, 3.days.from_now.to_date) }
  scope :due_later, -> { where("due_date > ?", 3.days.from_now.to_date) }
 
  validates :description, presence: true
 
  has_many :task_details, dependent: :delete_all
end