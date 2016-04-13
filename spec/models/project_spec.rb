require 'rails_helper'

RSpec.describe Project, type: :model do

  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:user_id) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:tasks).dependent(:destroy) }

end
