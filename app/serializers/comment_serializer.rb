class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :task_id
end
