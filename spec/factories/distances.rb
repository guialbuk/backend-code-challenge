FactoryBot.define do
  factory :distance do
    origin { ('A'..'Z').to_a[0..-2].sample }
    destination 'Z'
    length { rand(1..100000) }
  end
end
