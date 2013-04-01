FactoryGirl.define do
  sequence :imdb_id

  factory :list do
    name "my list"
  end

  factory :movie do
    title "My Movie: The Revenge of My Movie"
    imdb_id { generate(:imdb_id) }
  end

  factory :genre do
    name "Crap Films r Us"
  end
end