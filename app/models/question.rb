class Question < ApplicationRecord
  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :choices, dependent: :destroy
end
