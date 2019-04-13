FactoryBot.define do
  factory :library_assignment do
    libraryable_id { 1 }
    libraryable_type { "MyString" }
  end
end
