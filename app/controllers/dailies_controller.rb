class DailiesController < ApplicationController
  # GET /dailies
  # GET /dailies.json
  def index
    @dailies = Daily.all
    @daily = Daily.new
    @query_date = Time.now.strftime("%Y-%m-%d")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dailies }
    end
  end

  def someday
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    dailies = dailies.select {|daily| current_user and daily.user == current_user}
    @cur_daily = dailies.first if dailies and dailies.size > 0
    @daily = Daily.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dailies }
    end
  end

  def group
    @query_date = params[:date]
    @query_date = Time.now.strftime("%Y-%m-%d") unless @query_date
    dailies = Daily.where("date like ?", "#{@query_date}%").order("id DESC")
    users = User.all
    @users_dailies = []
    users.each do |user|
      is_find = false
      dailies.each do |daily|
        if daily.user == user
          if daily.date.strftime("%Y-%m-%d") < daily.created_at.strftime("%Y-%m-%d")
            @users_dailies << {:user=>user, :status=>Setting.dailies.send_overdate, :daily=>daily}
          else
            @users_dailies << {:user=>user, :status=>Setting.dailies.send_ontime, :daily=>daily}
          end
          is_find = true
          break
        end
      end
      
      @users_dailies << {:user=>user, :status=>Setting.dailies.send_not, :daily=>nil} unless is_find
    end
  end

  # GET /dailies/1
  # GET /dailies/1.json
  def show
    @daily = Daily.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @daily }
    end
  end

  # GET /dailies/new
  # GET /dailies/new.json
  def new
    @daily = Daily.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @daily }
    end
  end

  # GET /dailies/1/edit
  def edit
    @daily = Daily.find(params[:id])
  end

  # POST /dailies
  # POST /dailies.json
  def create
    @daily = Daily.new(params[:daily])
    @daily.user = current_user

    respond_to do |format|
      if @daily.save
        format.html { redirect_to @daily, notice: 'Daily was successfully created.' }
        format.json { render json: @daily, status: :created, location: @daily }
      else
        format.html { render action: "new" }
        format.json { render json: @daily.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dailies/1
  # PUT /dailies/1.json
  def update
    @daily = Daily.find(params[:id])

    respond_to do |format|
      if @daily.update_attributes(params[:daily])
        format.html { redirect_to @daily, notice: 'Daily was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @daily.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dailies/1
  # DELETE /dailies/1.json
  def destroy
    @daily = Daily.find(params[:id])
    @daily.destroy

    respond_to do |format|
      format.html { redirect_to dailies_url }
      format.json { head :no_content }
    end
  end
end
