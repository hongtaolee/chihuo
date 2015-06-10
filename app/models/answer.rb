class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey

  has_many :choices, dependent: :destroy
  has_many :dishes, through: :choices

  validates :user_id, uniqueness: { scope: :survey_id }
end
