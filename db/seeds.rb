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

30.times do |x|
  title = Faker::Hipster.sentence(word_count: 3)
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
  post = Post.create(title: title, body: body, user_id: User.first.id)

  10.times do |y|
    comment = Faker::Hipster.sentence(word_count: 3)
    Comment.create(post_id: post.id, body: comment, user_id: User.second.id)
  end
end
