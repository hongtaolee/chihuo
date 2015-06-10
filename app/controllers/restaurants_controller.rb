class RestaurantsController < ApplicationController
  before_action :set_group
  before_action :set_restaurants
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  # layout 'restaurants'

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = @group.restaurants

    if @restaurants.any?
      redirect_to [@group, @restaurants.first]
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @dishes = @restaurant.dishes
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new(group_id: @group.id)
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to [@group, @restaurant], notice: '餐馆添加成功' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to [@group, @restaurant], notice: '编辑餐馆成功' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    respond_to do |format|
      if @restaurant.destroy
        format.html { redirect_to group_restaurants_url(@group), notice: '删除成功' }
        format.json { head :no_content }
      else
        format.html { redirect_to group_restaurants_url(@group), alert: '删除失败' }
      end
    end
  end

  private
  def set_restaurants
    @restaurants = @group.restaurants
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :group_id)
  end
end
