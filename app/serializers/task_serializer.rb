class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :deadline, :position, :done, :project_id

  # belongs_to :project
end
