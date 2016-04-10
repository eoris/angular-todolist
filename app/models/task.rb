class Task < ActiveRecord::Base
  belongs_to :project
  has_many  :comments, dependent: :destroy
  validates :title, :project_id, presence: true

  default_scope { order('position ASC') }
  default_scope { order('id ASC') }
end
