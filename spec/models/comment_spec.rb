require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { is_expected.to have_db_column(:text) }
  it { is_expected.to have_db_column(:task_id) }

  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:task_id) }

  it { is_expected.to belong_to(:task) }
  it { is_expected.to have_many(:attachments).dependent(:destroy) }

end

