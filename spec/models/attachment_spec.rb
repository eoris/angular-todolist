require 'rails_helper'

RSpec.describe Attachment, type: :model do

  it { is_expected.to have_db_column(:file) }
  it { is_expected.to have_db_column(:comment_id) }

  it { is_expected.to validate_presence_of(:file) }
  it { is_expected.to validate_presence_of(:comment_id) }

  it { is_expected.to belong_to(:comment) }
end
