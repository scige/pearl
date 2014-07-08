require 'spec_helper'

describe DailiesController do

  describe "Get #show" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
    end

    it "assigns the requested daily to @daily" do
      daily = create(:daily, :user=>@user)
      get :show, id: daily
      expect(assigns(:daily)).to eq daily
    end

    it "renders the :show template" do
      daily = create(:daily, :user=>@user)
      get :show, id: daily
      expect(response).to render_template :show
    end

    it "assigns a array of comments with different user" do
      daily = create(:daily, :user=>@user)
      comment = create(:comment, daily: daily, user: @user)
      user_teacher = create(:user_teacher, :group=>@group)
      comment2 = create(:comment_teacher, daily: daily, user: user_teacher)
      get :show, id: daily
      expect(assigns(:comments)).to match_array([comment, comment2])
    end

    it "assigns a new comment to @comment" do
      daily = create(:daily, :user=>@user)
      get :show, id: daily
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "Get #my" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
    end

    it "assigns the requested daily to @cur_daily when don't pass params[:date] and exist a daily" do
      daily = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :user=>@user)
      get :my
      expect(assigns(:cur_daily)).to eq daily
      expect(assigns(:cur_daily).user).to eq @user
    end

    it "assigns the requested daily to @cur_daily when don't pass params[:date] and don't exist a daily" do
      get :my
      expect(assigns(:cur_daily)).to eq nil
      expect(assigns(:daily)).to be_a_new(Daily)
    end

    it "assigns the requested daily to @cur_daily when pass params[:date] and exist a daily" do
      daily = create(:daily, :date=>"2014-07-01".to_time, :user=>@user)
      get :my, :date=>"2014-07-01"
      expect(assigns(:cur_daily)).to eq daily
      expect(assigns(:cur_daily).user).to eq @user
    end

    it "assigns the requested daily to @cur_daily when pass params[:date] and don't exist a daily" do
      get :my, :date=>"2014-07-01"
      expect(assigns(:cur_daily)).to eq nil
      expect(assigns(:daily)).to be_a_new(Daily)
    end
  end

  describe "Post #create" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new daily in the database" do
        expect{
          post :create, :daily=>attributes_for(:daily, :date=>Time.now.strftime("%Y-%m-%d"))
        }.to change(Daily, :count).by(1)
      end

      it "redirects to dailies/my/#{Time.now.strftime("%Y-%m-%d")}" do
        post :create, :daily=>attributes_for(:daily, :date=>Time.now.strftime("%Y-%m-%d"))
        expect(response).to redirect_to "/dailies/my/#{Time.now.strftime("%Y-%m-%d")}"
      end
    end

    context "with invalid attributes" do
      it "does not save the new daily in the database" do
        expect{
          post :create, :daily=>attributes_for(:daily, :content=>nil, :date=>Time.now.strftime("%Y-%m-%d"))
        }.to_not change(Daily, :count)
      end

      it "redirects to dailies/my/#{Time.now.strftime("%Y-%m-%d")}" do
        post :create, :daily=>attributes_for(:daily, :content=>nil, :date=>Time.now.strftime("%Y-%m-%d"))
        expect(response).to redirect_to "/dailies/my/#{Time.now.strftime("%Y-%m-%d")}"
      end
    end

    it "can't write two dailies each person everyday" do
      daily = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :user=>@user)
      expect{
        post :create, :daily=>attributes_for(:daily, :date=>Time.now.strftime("%Y-%m-%d"))
      }.to_not change(Daily, :count)
    end

    it "can write two dailies two people everyday" do
      user2 = create(:user_student_2, :group=>@group)
      daily = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :user=>user2)
      expect{
        post :create, :daily=>attributes_for(:daily, :date=>Time.now.strftime("%Y-%m-%d"))
      }.to change(Daily, :count).by(1)
    end

    it "can't write the daily for a furture date" do
      expect{
        post :create, :daily=>attributes_for(:daily, :date=>(Time.now+1.day).strftime("%Y-%m-%d"))
      }.to_not change(Daily, :count)
    end
  end

  describe "Put #update" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @daily = create(:daily, :date=>Time.now.strftime("%Y-%m-%d"), :user=>@user)
    end

    context "with valid attributes" do
      it "changes @daily's attributes" do
        put :update, :id=>@daily, :daily=>attributes_for(:daily, :content=>"world cup", :date=>"2014-07-01".to_time)
        @daily.reload
        expect(@daily.content).to eq "world cup"
        expect(@daily.date).to eq "2014-07-01".to_time
      end

      it "redirects to dailies/my/#{Time.now.strftime("%Y-%m-%d")}" do
        put :update, :id=>@daily, :daily=>attributes_for(:daily, :date=>Time.now.strftime("%Y-%m-%d"))
        expect(response).to redirect_to "/dailies/my/#{Time.now.strftime("%Y-%m-%d")}"
      end
    end

    context "with invalid attributes" do
      it "does not change the new daily in the database" do
        put :update, :id=>@daily, :daily=>attributes_for(:daily, :content=>nil, :date=>"2014-07-01".to_time)
        @daily.reload
        expect(@daily.content).to eq "nice day"
        expect(@daily.date.strftime("%Y-%m-%d")).to eq Time.now.strftime("%Y-%m-%d")
      end

      it "redirects to dailies/my/#{Time.now.strftime("%Y-%m-%d")}" do
        put :update, :id=>@daily, :daily=>attributes_for(:daily, :content=>nil, :date=>"2014-07-01".to_time)
        @daily.reload
        expect(response).to redirect_to "/dailies/my/#{Time.now.strftime("%Y-%m-%d")}"
      end
    end
  end

  describe "Get #group" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  describe "Get #subgroup" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
