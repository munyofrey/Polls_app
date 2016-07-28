class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_poll
    self_id = self.id.to_s
    answer_hash = {}
    polls = Poll.find_by_sql(<<-SQL)
      SELECT
        polls.* poll_title, COUNT(DISTINCT questions.id) AS q_count, COUNT(DISTINCT responses_user.id) AS r_count
      FROM
        polls LEFT OUTER JOIN questions ON questions.poll_id = polls.id
              FULL OUTER JOIN answer_choices ON answer_choices.question_id = questions.id
              LEFT OUTER JOIN
                (SELECT
                *
                FROM
                responses
                WHERE
                responses.user_id = #{self_id})
                responses_user ON answer_choices.id = responses_user.answer_choice_id
      WHERE polls.user_id != #{self_id}
      GROUP BY  polls.id
    SQL
    complete = []
    polls.each do |poll|
      complete << poll if poll.q_count == poll.r_count
    end
    complete


  end
end

#
#
# SELECT COUNT(responses) AS count_responses, polls.title AS polls_title
# FROM "polls"
#   LEFT OUTER JOIN responses
#   ON responses.user_id = polls.user_id
# WHERE (NOT (polls.user_id = 1))
# AND responses.user_id = id
# GROUP BY polls.title
