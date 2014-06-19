# coding: utf-8

class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @documents = @project.documents
    @document = @documents[0] if @documents.size > 0
  end

  def show
    @project = Project.find(params[:project_id])
    @documents = @project.documents
    @document = Document.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @documents = @project.documents
    @document = Document.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @documents = @project.documents
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    @project = Project.find(params[:project_id])
    @document.project = @project
    @document.user = current_user

    if @document.save
      redirect_to project_document_url(@project, @document)
    else
      flash[:error] = "输入内容缺失或存在错误，新建文档失败！"
      redirect_to new_project_document_url(@project)
    end
  end

  def update
    @document = Document.find(params[:id])
    @project = Project.find(params[:project_id])

    if @document.update_attributes(params[:document])
      redirect_to project_document_url(@project, @document)
    else
      flash[:error] = "输入内容缺失或存在错误，编辑文档失败！"
      redirect_to edit_project_document_url(@project, @document)
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    @project = Project.find(params[:project_id])
    redirect_to project_documents_url(@project)
  end
end
