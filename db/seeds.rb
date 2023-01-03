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

posts = []
comments = []

elapsed = Benchmark.measure do
  1000.times do |x|
    puts "Creating post #{x}"
    title = Faker::Hipster.sentence(word_count: 3)
    body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
    post = Post.new(title: title, body: body, user_id: User.first.id)
    posts.push(post)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      fake_comment = Faker::Hipster.sentence(word_count: 3)
      comment = post.comments.new(post_id: post.id, body: fake_comment, user_id: User.second.id)
      comments.push(comment)
    end
  end
end

Post.import(posts)
Comment.import(comments)
puts "Post #{posts.count} posts and #{comments.count} comments in #{elapsed.real} seconds"
