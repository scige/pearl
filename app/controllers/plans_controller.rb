class PlansController < ApplicationController
  before_filter :authenticate_user!

  def index
    @plans = current_user.plans
    @plan = Plan.new

    @none_plans = []
    @active_plans = []
    @finish_plans = []
    @other_plans = []

    @plans.each do |plan|
      if plan.status == Setting.plans.status_none
        @none_plans << plan
      elsif plan.status == Setting.plans.status_active
        @active_plans << plan
      elsif plan.status == Setting.plans.status_finish
        @finish_plans << plan
      elsif plan.status == Setting.plans.status_canceled
        @other_plans << plan
      elsif plan.status == Setting.plans.status_postponed
        @other_plans << plan
      end
    end
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = Plan.new(params[:plan])
    @plan.user = current_user
    @plan.status = Setting.plans.status_none

    if @plan.save
      redirect_to plans_url
    else
      render action: "new"
    end
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.user = current_user

    if @plan.update_attributes(params[:plan])
      redirect_to @plan
    else
      render action: "edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    redirect_to plans_url
  end

  def update_status
    @plan = Plan.find(params[:id])
    status = params[:status].to_i

    if status >= Setting.plans.status_none and status <= Setting.plans.status_postponed
      @plan.status = status
      @plan.save
    end

    redirect_to plans_url
  end
end
