FactoryBot.define do
  factory :answer do
    content { 'どちらでも構いません、決定するのはあなたです' }
    user
    question
    already_read { 0 }
  end
end