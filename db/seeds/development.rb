# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Seeding development database...'

yury = User.first_or_create!(email: 'yury@kornelyuk.com',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'Yury',
                             last_name: 'Kornelyuk',
                             role: User.roles[:admin])

john = User.first_or_create!(email: 'john@doe.com',
                             password: 'password',
                             password_confirmation: 'password',
                             first_name: 'John',
                             last_name: 'Doe')

Address.first_or_create!(street: '123 Main St',
                         city: 'Anytown',
                         state: 'CA',
                         zip: '12345',
                         country: 'USA',
                         user: yury)

Address.first_or_create(street: '123 Main St',
                        city: 'Anytown',
                        state: 'CA',
                        zip: '12345',
                        country: 'USA',
                        user: john)

elapsed = Benchmark.measure do
  posts = []
  100.times do |x|
    puts "Creating post #{x}"
    title_p = Faker::Hipster.sentence(word_count: 3)
    body_p = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
    post = Post.new(title: title_p,
                    body: body_p,
                    user: yury)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      body_c = Faker::Hipster.sentence(word_count: 5)
      post.comments.build(body: body_c,
                          user: john)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"