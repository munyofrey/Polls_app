# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(user_name: 'Munyo')
User.create!(user_name: 'Jangmi')

Poll.create!(title: 'Poll one', user_id: 1)
Poll.create!(title: 'Poll two', user_id: 2)
Poll.create!(title: 'Poll three', user_id: 1)
Poll.create!(title: 'Poll four', user_id: 2)

Question.create!(poll_id: 1, text: 'Do you like chocolate?')
Question.create!(poll_id: 2, text: 'How is your day?')

AnswerChoice.create!(question_id: 1, text: 'I love it!')
AnswerChoice.create!(question_id: 1, text: 'EWWWWWW!')
AnswerChoice.create!(question_id: 1, text: 'It\'s okay.')
AnswerChoice.create!(question_id: 1, text: 'Not really.')

AnswerChoice.create!(question_id: 2, text: 'Great.')
AnswerChoice.create!(question_id: 2, text: 'So, so.')
AnswerChoice.create!(question_id: 2, text: 'Fantastic!')
AnswerChoice.create!(question_id: 2, text: 'The WORST!')

Response.create!(user_id: 1, answer_choice_id: 5)
Response.create!(user_id: 2, answer_choice_id: 4)
