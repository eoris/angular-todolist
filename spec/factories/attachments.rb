FactoryGirl.define do
  factory :attachment do
    comment
    file { File.open(File.join(Rails.root, '/spec/fixtures/files/lorem.txt')) }
  end
end
