class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_not_great
    poll_results = {}

    answer_choices = self.answer_choices.includes(:responses)

    answer_choices.each do |choice|
      poll_results[choice.text] = choice.responses.length
    end
    poll_results
  end

  def results
    self.answer_choices.joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id').group('answer_choices.text').count(:answer_choice_id)
  end
end
