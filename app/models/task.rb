class Task < ActiveRecord::Base
  belongs_to :project
  has_many  :comments, dependent: :destroy
  validates :title, :project_id, presence: true
end
