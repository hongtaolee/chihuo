class Restaurant < ActiveRecord::Base
  belongs_to :group
  has_many :dishes, dependent: :destroy

  validates :name, presence: true
end
