require 'spec_helper'

describe CommentsController do

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user

      @daily = create(:daily, :user=>@user)
    end

    context "with valid attributes" do
      it "saves the new comment in the database" do
        expect{
          post :create, :comment=>attributes_for(:comment, :daily_id=>@daily.id)
        }.to change(Comment, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new comment in the database, when pass invalid title" do
        expect{
          post :create, :comment=>attributes_for(:comment, :content=>nil, :daily_id=>@daily.id)
        }.not_to change(Comment, :count)
      end

      it "doesn't save the new comment in the database, when don't pass daily_id" do
        expect{
          post :create, :comment=>attributes_for(:comment, :daily_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user

      @daily = create(:daily, :user=>@user)
      @comment = create(:comment, :daily=>@daily, :user=>@user)
    end

    it "deletes the comment" do
      expect{
        delete :destroy, :id=>@comment.id
      }.to change(Comment, :count).by(-1)
    end
  end

end
