class Question < ApplicationRecord
  include CheckValidations
  has_many :choices, dependent: :destroy
end
