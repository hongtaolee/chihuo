class SurveysController < ApplicationController
  before_action :set_group

  def new
    # TODO: 初始化 deadline
    deadline = (DateTime.now + 30.minutes)
    @survey = Survey.new(group_id: @group.id, user_id: current_user.id)
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.published_at = DateTime.now
    dishes = params[:dishes] || []
    @survey.alternative_dishes = Dish.find(dishes).collect { |d| @survey.alternative_dishes.build(dish_id: d.id) }

    if @survey.save
      redirect_to @group, notice: '发起成功'
    else
      flash[:alert]= @survey.errors.full_messages.first
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
    @answer = Answer.where(survey_id: @survey.id, user_id: current_user).last
    if @answer.blank? && user_signed_in?
      @answer = Answer.new(survey_id: @survey.id, user_id: current_user.id)
    end

    dish_counts = Choice.joins(:answer)
                         .select("dish_id, count(choices.id) as count")
                         .where(answers: {survey_id: @survey.id})
                         .group(:dish_id)

    # dish 统计
    @dish_counts = Hash[dish_counts.map {|choice| [choice.dish_id, choice.count] }]
  end

  private
  def survey_params
    params.require(:survey).permit(:group_id, :user_id, :deadline)
  end

end
