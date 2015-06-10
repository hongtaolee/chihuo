module ApplicationHelper

	def relative_days(datetime)
		days = (Date.today - datetime.to_date).to_i
		if days == 0
		end
		letter = case days
			when 0
			 '今天'
			when 1
			 '昨天'
			when 2
			 '前天'
			else
				datetime.strftime('%-m月%-d日')
			end

		letter
	end

end
