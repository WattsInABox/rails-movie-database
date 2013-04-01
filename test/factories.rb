FactoryGirl.define do
  sequence :imdb_id

  factory :list do
    name "my list"
  end

  factory :movie do
    title "My Movie"
    short_description "Short Description"
    imdb_id { generate(:imdb_id) }
  end

  factory :genre do
    name "Crap Films r Us"
  end
end