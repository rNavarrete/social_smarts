FactoryGirl.define do
  factory :tracked_tweet do
    text "tweeting"
    screen_name "lukeaiken"
    created_at "datetime"
    klout_score 55
    status "unresolved"
  end
end
