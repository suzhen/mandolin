FactoryBot.define do
  factory :contract_assignment do
    contract_id { 1 }
    contractable_id { 1 }
    contractable_type { "MyString" }
  end
end
