# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'yury@kornelyuk.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'Yury',
            role: User.roles[:admin])
User.create(email: 'john@doe.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'John Doe')


elapsed = Benchmark.measure do
  posts = []
  yury = User.first
  john = User.second
  1000.times do |x|
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

puts "Elapsed time is #{elapsed.real} seconds"