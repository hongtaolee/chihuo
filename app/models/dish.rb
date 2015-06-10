class Dish < ActiveRecord::Base
  belongs_to :restaurant

  has_many :choices
  has_many :alternative_dishes

  validates :name, presence: true
  validates :name, uniqueness: {scope: :restaurant_id}
  before_destroy :has_association_data

  # TODO: before_destroy 有 survey 使用的 dish 不能删除

  def full_name
    "#{self.restaurant.name} - #{self.name}"
  end

  def has_association_data
    if !self.choices.empty? || !self.alternative_dishes.empty?
      errors[:base] << "已经产生关联数据了"
      return false
    end
  end
end
