class SuggestQuestion < ApplicationRecord
  include CheckValidations
  belongs_to :user

  validates :user_id, presence: true

  after_update :generate_question

  enum status: [:unapproved, :rejected, :approved]

  private
  def generate_question
    if approved?
      question = Question.new subject: subject, content: content
      question.answers << answers
      question.save
    end
  end
end
