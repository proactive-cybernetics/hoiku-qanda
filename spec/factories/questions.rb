FactoryBot.define do
  factory :question do
    title { 'バナナはおやつに入りますか?' }
    content { 'どうしたらいいでしょうか??' }
    status { 0 }
    user
  end
end