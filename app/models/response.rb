class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :no_author_responses

  def not_duplicate_response
    if respondent_already_answered?
      errors[:respondent] << 'already answered.'
    end
  end

  def no_author_responses
    if authored_poll?
      errors[:Author] << 'can\'t respond to their own poll.'
    end

  end


  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def authored_poll?
    question.poll.author.id == user_id
  end

end
