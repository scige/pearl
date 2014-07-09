require 'spec_helper'

describe ReviewsController do

  describe "Post #create" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user
    end

    context "with valid attributes" do
      it "saves the new review in the database, for thesis" do
        @thesis = create(:thesis, :user=>@user)
        @document = create(:document, :user=>@user, :thesis=>@thesis, :category=>Setting.documents.category_thesis)
        expect{
          post :create, :review=>attributes_for(:review, :document_id=>@document.id)
        }.to change(Review, :count).by(1)
      end

      it "saves the new review in the database, for paper" do
        @paper = create(:paper, :user=>@user)
        @document = create(:document, :user=>@user, :paper=>@paper, :category=>Setting.documents.category_paper)
        expect{
          post :create, :review=>attributes_for(:review, :document_id=>@document.id)
        }.to change(Review, :count).by(1)
      end

      it "saves the new review in the database, for patent" do
        @patent = create(:patent, :user=>@user)
        @document = create(:document, :user=>@user, :patent=>@patent, :category=>Setting.documents.category_patent)
        expect{
          post :create, :review=>attributes_for(:review, :document_id=>@document.id)
        }.to change(Review, :count).by(1)
      end

      it "saves the new review in the database, for project" do
        @project = create(:project, :user=>@user)
        @document = create(:document, :user=>@user, :project=>@project, :category=>Setting.documents.category_project)
        expect{
          post :create, :review=>attributes_for(:review, :document_id=>@document.id)
        }.to change(Review, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new review in the database, when pass invalid title" do
        @thesis = create(:thesis, :user=>@user)
        @document = create(:document, :user=>@user, :thesis=>@thesis, :category=>Setting.documents.category_thesis)
        expect{
          post :create, :review=>attributes_for(:review, :content=>nil, :document_id=>@document.id)
        }.not_to change(Review, :count)
      end

      it "doesn't save the new review in the database, when don't pass document_id" do
        @thesis = create(:thesis, :user=>@user)
        @document = create(:document, :user=>@user, :thesis=>@thesis, :category=>Setting.documents.category_thesis)
        expect{
          post :create, :review=>attributes_for(:review, :document_id=>nil)
        }.to raise_error
      end
    end
  end

  describe "Delete #destory" do
    before :each do
      @user = create(:user_student)
      sign_in :user, @user

      @thesis = create(:thesis, :user=>@user)
      @document = create(:document, :user=>@user, :thesis=>@thesis, :category=>Setting.documents.category_thesis)
      @review = create(:review, :document=>@document, :user=>@user)
    end

    it "deletes the review" do
      expect{
        delete :destroy, :id=>@review.id
      }.to change(Review, :count).by(-1)
    end
  end

end
