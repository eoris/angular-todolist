class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :task_id

  has_many :attachments
end
