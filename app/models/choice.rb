class Choice < ActiveRecord::Base
  belongs_to :answer
  belongs_to :dish
end
