class AnswersController < ApplicationController
  before_action :set_group

  def create
    @answer = Answer.new(answer_params)
    dish_ids = params[:answer][:dish_ids]
    if dish_ids.blank? || dish_ids.empty?
      redirect_to [@group, Survey.find(answer_params[:survey_id])], alert: '请选菜' and return
    end

    @answer.choices = dish_ids.collect { |dish_id| @answer.choices.build(dish_id: dish_id) }

    if @answer.save
      redirect_to [@group, Survey.find(answer_params[:survey_id])], notice: '添加成功'
    else
      redirect_to [@group, Survey.find(answer_params[:survey_id])], alert: '添加失败'
    end
  end

  def update
    @answer = Answer.find params[:id]

    dish_ids = params[:answer][:dish_ids]
    if dish_ids.blank? || dish_ids.empty?
      redirect_to [@group, Survey.find(answer_params[:survey_id])], alert: '请选菜' and return
    end

    @answer.choices = dish_ids.collect { |dish_id| @answer.choices.build(dish_id: dish_id) }

    if @answer.save
      redirect_to [@group, Survey.find(answer_params[:survey_id])], notice: '添加成功'
    else
      redirect_to [@group, Survey.find(answer_params[:survey_id])], alert: '添加失败'
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    @answer.destroy

    redirect_to [@group, @answer.survey], notice: '删除成功'
  end


  private
  def answer_params
    # TODO: nested form 2014-08-10
    params.require(:answer).permit(:user_id, :survey_id)
  end

end
