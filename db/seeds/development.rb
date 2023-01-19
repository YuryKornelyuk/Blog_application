# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


def seed_users
  User.create(email: 'yury@kornelyuk.com',
              password: 'password',
              password_confirmation: 'password',
              first_name: 'Yury',
              last_name: 'Kornelyuk',
              role: User.roles[:admin])

  User.create(email: 'john@doe.com',
              password: 'password',
              password_confirmation: 'password',
              first_name: 'John',
              last_name: 'Doe')
end

def seed_addresses
  Address.create(street: '123 Main St',
                           city: 'Anytown',
                           state: 'CA',
                           zip: '12345',
                           country: 'USA',
                           user: User.first)

  Address.create(street: '123 Main St',
                          city: 'Anytown',
                          state: 'CA',
                          zip: '12345',
                          country: 'USA',
                          user: User.second)
end

def seed_categories
  Category.create(title: 'Uncategorized')
  Category.create(title: 'General')
  Category.create(title: 'Finance')
  Category.create(title: 'Health')
  Category.create(title: 'Education')
end

def seed_posts_and_comments
  posts = []
  100.times do |x|
    puts "Creating post #{x}"
    title_post = Faker::Hipster.sentence(word_count: 3)
    body_post = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
    post = Post.new(title: title_post,
                    body: body_post,
                    user: User.all.sample,
                    category_id: Category.all.sample.id)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      body_comment = Faker::Hipster.sentence(word_count: 5)
      post.comments.build(body: body_comment,
                          user: User.all.sample)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

def seed_ahoy
  Ahoy.geocode = false
  request = OpenStruct.new(
    params: {},
    referer: 'http://example.com',
    remote_ip: '0.0.0.0',
    user_agent: 'Internet Explorer',
    original_url: 'rails'
  )

  visit_properties = Ahoy::VisitProperties.new(request, api: nil)
  properties = visit_properties.generate.select { |_, v| v }

  example_visit = Ahoy::Visit.create!(properties.merge(
                                        visit_token: SecureRandom.uuid,
                                        visitor_token: SecureRandom.uuid
                                      ))

  2.months.ago.to_date.upto(Date.today) do |date|
    Post.all.each do |post|
      rand(1..10).times do |_x|
        Ahoy::Event.create!(name: 'Viewed Post',
                            visit: example_visit,
                            properties: { post_id: post.id },
                            time: date.to_time + rand(0..23).hours + rand(0..59).minutes)
      end
    end
  end
end

elapsed = Benchmark.measure do
  puts 'Seeding development database...'
  seed_users
  seed_addresses
  seed_categories
  seed_posts_and_comments
  seed_ahoy
end

puts "Seeded development DB in #{elapsed.real} seconds"
