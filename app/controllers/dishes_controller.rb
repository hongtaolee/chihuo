class DishesController < ApplicationController
	before_action :set_group
	before_action :set_restaurant

	def create
		@dish = Dish.new(dish_params)
		if @dish.save
			flash[:notice] = '添加成功'
		else
			flash[:alert] = '添加失败 - ' + @dish.errors.full_messages.join(', ')
		end

		redirect_to [@group, @restaurant]
	end	

	def destroy
    @dish = Dish.find params[:id]
		if @dish.destroy
			flash[:notice] = '删除成功'
		else
			flash[:alert] = '删除失败, 已经产生关联数据'
		end
		redirect_to [@group, @restaurant]
	end

	private
	def dish_params
		params.require(:dish).permit(:name, :restaurant_id)
	end

	def set_restaurant
    @restaurant = Restaurant.find params[:restaurant_id]
	end	

end
