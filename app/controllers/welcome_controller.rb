class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def index

  	# 如果用户登录进入 group 页面
  	if user_signed_in?
  		redirect_to group_path(current_user.group)
  	end

  end
end
