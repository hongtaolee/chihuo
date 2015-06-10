class AlternativeDish < ActiveRecord::Base
  belongs_to :survey
  belongs_to :dish

  validates :dish, uniqueness: { scope: :survey_id }
end
