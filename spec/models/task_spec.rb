require 'rails_helper'

RSpec.describe Task, type: :model do

  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:deadline) }
  it { is_expected.to have_db_column(:position) }
  it { is_expected.to have_db_column(:done) }
  it { is_expected.to have_db_column(:project_id) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:project_id) }

  it { is_expected.to belong_to(:project) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }

end
