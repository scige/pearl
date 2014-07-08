require 'spec_helper'

describe PapersController do

  describe "Get #index" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user

      @group2 = create(:group_2)
      @user2 = create(:user_student_2, :group=>@group2)
    end

    it "populates an array of papers belong to user's group" do
      paper = create(:paper, :user=>@user)
      paper2 = create(:paper_2, :user=>@user)
      paper3 = create(:paper_3, :user=>@user2)
      get :index
      expect(assigns(:papers)).to match_array([paper, paper2])
    end
  end

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new paper in the database" do
        expect{
          post :create, :paper=>attributes_for(:paper, :user_id=>@user.id)
        }.to change(Paper, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new paper in the database, when pass invalid title" do
        expect{
          post :create, :paper=>attributes_for(:paper, :title=>nil, :user_id=>@user.id)
        }.not_to change(Paper, :count)
      end

      it "doesn't save the new paper in the database, when don't pass user_id" do
        expect{
          post :create, :paper=>attributes_for(:paper, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Put #update" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
      @paper = create(:paper, :user=>@user)
    end

    context "with valid attributes" do
      it "changes the paper's attributes" do
        @user2 = create(:user_student_2, :group=>@group)
        put :update, :id=>@paper.id, :paper=>attributes_for(:paper, :title=>"Smart house", :user_id=>@user2.id)
        @paper.reload
        expect(@paper.title).to eq "Smart house"
        expect(@paper.user).to eq @user2
      end
    end

    context "with invalid attributes" do
      it "doesn't change the paper's attributes, when pass invalid status" do
        put :update, :id=>@paper.id, :paper=>attributes_for(:paper, :title=>"Smart house", :status=>"one", :user_id=>@user.id)
        @paper.reload
        expect(@paper.title).not_to eq "Smart house"
        expect(@paper.status).to eq Setting.papers.status_accept
      end

      it "doesn't change the paper's attributes, when don't pass user_id" do
        expect{
          put :update, :id=>@paper.id, :paper=>attributes_for(:paper, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @paper = create(:paper, :user=>@user)
    end

    it "deletes the paper" do
      expect{
        delete :destroy, :id=>@paper.id
      }.to change(Paper, :count).by(-1)
    end
  end
end
