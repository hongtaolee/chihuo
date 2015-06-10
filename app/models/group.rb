class Group < ActiveRecord::Base

	has_many :users
	has_many :restaurants
	has_many :surveys

	validates :name, presence: true

end
