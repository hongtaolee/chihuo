class GroupsController < ApplicationController
  def show
  	@group = Group.find params[:id]
  	@surveys = @group.surveys.order(published_at: :desc).page(params[:page]).per(6)

    start_date = (Time.now - 6.days).beginning_of_day
    end_date = Time.now.end_of_day
    puts start_date
    puts end_date
    # group -> survey -> answer -> choice
    @week_dishes = Choice.select('choices.dish_id as dish_id, count(choices.dish_id) as count ')
                        .joins(answer: :survey)
                        .where(surveys: { group_id: @group.id})
                        .where(choices: {created_at:  start_date..end_date})
                        .group('choices.dish_id')
                        .order('count desc')
                        .limit(10)
  end
end
