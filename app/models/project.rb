class Project < ActiveRecord::Base
  belongs_to :user
  has_many  :tasks, dependent: :destroy
  validates :title, :user_id, presence: true
end
