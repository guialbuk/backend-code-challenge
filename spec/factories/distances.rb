FactoryBot.define do
  factory :distance do
    origin { ('A'..'Z').to_a.sample }
    destination { (('A'..'Z').reject { |a| a == origin }).sample }
    length { rand(1..100000) }
  end
end
