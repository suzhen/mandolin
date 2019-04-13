FactoryBot.define do
  factory :contract do
    auth_party { "MyString" }
    op_type { "MyString" }
    auth_fee { "9.99" }
    auth_duration { 1 }
  end
end
