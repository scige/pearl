require 'spec_helper'

describe ProjectsController do

  describe "Get #index" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user

      @group2 = create(:group_2)
      @user2 = create(:user_student_2, :group=>@group2)
    end

    it "populates an array of projects belong to user's group" do
      project = create(:project, :user=>@user)
      project2 = create(:project_2, :user=>@user)
      project3 = create(:project_3, :user=>@user2)
      get :index
      expect(assigns(:projects)).to match_array([project, project2])
    end
  end

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new project in the database" do
        expect{
          post :create, :project=>attributes_for(:project, :user_id=>@user.id)
        }.to change(Project, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new project in the database, when pass invalid title" do
        expect{
          post :create, :project=>attributes_for(:project, :title=>nil, :user_id=>@user.id)
        }.not_to change(Project, :count)
      end

      it "doesn't save the new project in the database, when don't pass user_id" do
        expect{
          post :create, :project=>attributes_for(:project, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Put #update" do
    before :each do
      @group = create(:group)
      @user = create(:user_student, :group=>@group)
      sign_in :user, @user
      @project = create(:project, :user=>@user)
    end

    context "with valid attributes" do
      it "changes the project's attributes" do
        @user2 = create(:user_student_2, :group=>@group)
        put :update, :id=>@project.id, :project=>attributes_for(:project, :title=>"Smart house", :user_id=>@user2.id)
        @project.reload
        expect(@project.title).to eq "Smart house"
        expect(@project.user).to eq @user2
      end
    end

    context "with invalid attributes" do
      it "doesn't change the project's attributes, when pass invalid status" do
        put :update, :id=>@project.id, :project=>attributes_for(:project, :title=>"Smart house", :status=>"one", :user_id=>@user.id)
        @project.reload
        expect(@project.title).not_to eq "Smart house"
        expect(@project.status).to eq Setting.projects.status_applying
      end

      it "doesn't change the project's attributes, when don't pass user_id" do
        expect{
          put :update, :id=>@project.id, :project=>attributes_for(:project, :user_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
      @project = create(:project, :user=>@user)
    end

    it "deletes the project" do
      expect{
        delete :destroy, :id=>@project.id
      }.to change(Project, :count).by(-1)
    end
  end
end
