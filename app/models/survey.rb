class Survey < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :alternative_dishes, dependent: :destroy
  has_many :dishes, through: :alternative_dishes

  has_many :answers, dependent: :destroy

  validates :deadline, presence: true
  validate :require_alternative_dishes, on: :create

  # TODO: before_destroy 有回答的 survey 不允许删除

  def closed?
    self.deadline < DateTime.now
  end

  def open?
    !closed?
  end

  def require_alternative_dishes
    if self.alternative_dishes.empty?
      errors.add :alternative_dishes, '必须选菜'
    end
  end
end
