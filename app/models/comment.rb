class Comment < ActiveRecord::Base
  belongs_to :task
  validates :text, :task_id, presence: true
end
