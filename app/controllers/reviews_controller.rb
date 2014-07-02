# coding: utf-8

class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    document_id = params[:review].delete(:document_id)
    @document = Document.find(document_id)
    @review = Review.new(params[:review])
    @review.document = @document
    @review.user = current_user

    if @review.save
      if @document.category == Setting.documents.category_project
        redirect_to [@document.project, @document]
      elsif @document.category == Setting.documents.category_paper
        redirect_to [@document.paper, @document]
      elsif @document.category == Setting.documents.category_patent
        redirect_to [@document.patent, @document]
      elsif @document.category == Setting.documents.category_thesis
        redirect_to [@document.thesis, @document]
      else
        redirect_to root_url
      end
    else
      render action: "new"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_url
  end
end
