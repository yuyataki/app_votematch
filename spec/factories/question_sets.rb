FactoryGirl.define do
  factory :question_set do
    title '20XX年衆議院選挙!あなたの選択は?!'
    association :user
  end
end
