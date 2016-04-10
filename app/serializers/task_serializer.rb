class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :deadline, :position, :done, :project_id

  has_many :comments
end
