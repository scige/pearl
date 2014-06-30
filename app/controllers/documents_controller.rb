# coding: utf-8

class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    common_vars
    if @documents.size > 0
      @document = @documents[0]
    else
      @document = Document.new
    end
  end

  def show
    common_vars
    @document = Document.find(params[:id])
  end

  def new
    common_vars
    @document = Document.new
  end

  def edit
    common_vars
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    @object = nil
    @category = nil
    if params[:project_id]
      @category = Setting.documents.category_project
      @object = Project.find(params[:project_id])
      @document.project = @object
    elsif params[:paper_id]
      @category = Setting.documents.category_paper
      @object = Paper.find(params[:paper_id])
      @document.paper = @object
    elsif params[:patent_id]
      @category = Setting.documents.category_patent
      @object = Patent.find(params[:patent_id])
      @document.patent = @object
    elsif params[:thesis_id]
      @category = Setting.documents.category_thesis
      @object = Thesis.find(params[:thesis_id])
      @document.thesis = @object
    end
    @document.category = @category
    @document.user = current_user

    if @document.save
      if @category == Setting.documents.category_project
        redirect_to project_document_url(@object, @document)
      elsif @category == Setting.documents.category_paper
        redirect_to paper_document_url(@object, @document)
      elsif @category == Setting.documents.category_patent
        redirect_to patent_document_url(@object, @document)
      elsif @category == Setting.documents.category_thesis
        redirect_to thesis_document_url(@object, @document)
      end
    else
      flash[:error] = "输入内容缺失或存在错误，新建文档失败！"
      if @category == Setting.documents.category_project
        redirect_to new_project_document_url(@object)
      elsif @category == Setting.documents.category_paper
        redirect_to new_paper_document_url(@object)
      elsif @category == Setting.documents.category_patent
        redirect_to new_patent_document_url(@object)
      elsif @category == Setting.documents.category_thesis
        redirect_to new_thesis_document_url(@object)
      end
    end
  end

  def update
    @document = Document.find(params[:id])
    @object = nil
    @category = nil
    if params[:project_id]
      @category = Setting.documents.category_project
      @object = Project.find(params[:project_id])
    elsif params[:paper_id]
      @category = Setting.documents.category_paper
      @object = Paper.find(params[:paper_id])
    elsif params[:patent_id]
      @category = Setting.documents.category_patent
      @object = Patent.find(params[:patent_id])
    elsif params[:thesis_id]
      @category = Setting.documents.category_thesis
      @object = Thesis.find(params[:thesis_id])
    end

    if @document.update_attributes(params[:document])
      if @category == Setting.documents.category_project
        redirect_to project_document_url(@object, @document)
      elsif @category == Setting.documents.category_paper
        redirect_to paper_document_url(@object, @document)
      elsif @category == Setting.documents.category_patent
        redirect_to patent_document_url(@object, @document)
      elsif @category == Setting.documents.category_thesis
        redirect_to thesis_document_url(@object, @document)
      end
    else
      flash[:error] = "输入内容缺失或存在错误，编辑文档失败！"
      if @category == Setting.documents.category_project
        redirect_to edit_project_document_url(@object, @document)
      elsif @category == Setting.documents.category_paper
        redirect_to edit_paper_document_url(@object, @document)
      elsif @category == Setting.documents.category_patent
        redirect_to edit_patent_document_url(@object, @document)
      elsif @category == Setting.documents.category_thesis
        redirect_to edit_thesis_document_url(@object, @document)
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    @object = nil
    if params[:project_id]
      @object = Project.find(params[:project_id])
      redirect_to project_documents_url(@object)
    elsif params[:paper_id]
      @object = Paper.find(params[:paper_id])
      redirect_to paper_documents_url(@object)
    elsif params[:patent_id]
      @object = Patent.find(params[:patent_id])
      redirect_to patent_documents_url(@object)
    elsif params[:thesis_id]
      @object = Thesis.find(params[:thesis_id])
      redirect_to thesis_documents_url(@object)
    end
  end

  private

  def common_vars
    @object = nil
    @category = nil
    @documents = []
    if params[:project_id]
      @category = Setting.documents.category_project
      @object = Project.find(params[:project_id])
    elsif params[:paper_id]
      @category = Setting.documents.category_paper
      @object = Paper.find(params[:paper_id])
    elsif params[:patent_id]
      @category = Setting.documents.category_patent
      @object = Patent.find(params[:patent_id])
    elsif params[:thesis_id]
      @category = Setting.documents.category_thesis
      @object = Thesis.find(params[:thesis_id])
    end
    @documents = @object.documents
  end
end
