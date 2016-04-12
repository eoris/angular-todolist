class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :file, :comment_id, :file_identifier
end
