class Answer < ApplicationRecord
  belongs_to :answerable, polymorphic: true, optional: true
  has_many :choices, dependent: :destroy

  validates :content, presence: true
end
