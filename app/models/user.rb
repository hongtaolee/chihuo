class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :group

  # 限制使用公司邮箱
  validates :email, format: { with: /\A([^@\s]+)@17tutu.com\z/i, on: :create, message: "使用公司企业邮箱(xxx@17tutu.com)" }
  validates :name, presence: true, on: :create

  before_create :set_default_group

  alias_attribute :admin?, :admin

  private
  # 设置默认 group, 方便将来扩展
  def set_default_group
  	self.group = Group.first
  end

end
