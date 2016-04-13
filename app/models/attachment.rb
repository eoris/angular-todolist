class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentUploader
  belongs_to :comment
  validates  :file, :comment_id, presence: true
end
