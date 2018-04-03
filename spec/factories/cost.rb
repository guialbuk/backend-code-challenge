FactoryBot.define do
  factory :cost do
    origin { ('A'..'Z').to_a[0..-2].sample }
    destination 'Z'
    weight { rand(1..50) }
  end
end
